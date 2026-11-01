import json
import os
import shutil
import sys
import urllib.parse
import zipfile


def unique_path(directory, stem, extension, label):
    target = os.path.join(directory, stem + extension)
    attempt = 0
    while os.path.lexists(target):
        attempt += 1
        target = os.path.join(directory, stem + label(attempt) + extension)
    return target


def copy_label(attempt):
    return " - Copy" if attempt == 1 else f" - Copy ({attempt})"


def zip_label(attempt):
    return f" ({attempt + 1})"


def is_real_directory(path):
    return os.path.isdir(path) and not os.path.islink(path)


def transfer(destination, mode, sources):
    destination = os.path.abspath(destination)
    created = []
    moved = []
    for source in sources:
        source = os.path.abspath(source)
        name = os.path.basename(source)
        if not os.path.lexists(source):
            continue
        if mode == "move" and os.path.dirname(source) == destination:
            continue
        if is_real_directory(source):
            if destination == source or destination.startswith(source + os.sep):
                continue
            stem, extension = name, ""
        else:
            stem, extension = os.path.splitext(name)
        target = unique_path(destination, stem, extension, copy_label)
        if mode == "move":
            shutil.move(source, target)
            moved.append({"from": source, "to": target})
        elif is_real_directory(source):
            shutil.copytree(source, target, symlinks=True)
            created.append(target)
        else:
            shutil.copy2(source, target, follow_symlinks=False)
            created.append(target)
    return {"created": created, "moved": moved}


def compress(destination, sources):
    sources = [os.path.abspath(source) for source in sources if os.path.lexists(source)]
    if not sources:
        return {"created": [], "moved": []}
    first = sources[0]
    name = os.path.basename(first)
    stem = name if is_real_directory(first) else os.path.splitext(name)[0]
    archive = unique_path(os.path.abspath(destination), stem, ".zip", zip_label)
    with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as bundle:
        for source in sources:
            parent = os.path.dirname(source)
            if not is_real_directory(source):
                bundle.write(source, os.path.basename(source))
                continue
            for root, directories, files in os.walk(source):
                bundle.write(root, os.path.relpath(root, parent))
                for file in files:
                    path = os.path.join(root, file)
                    bundle.write(path, os.path.relpath(path, parent))
    return {"created": [archive], "moved": []}


def trash_base():
    data_home = os.environ.get("XDG_DATA_HOME") or os.path.join(os.path.expanduser("~"), ".local", "share")
    return os.path.join(data_home, "Trash")


def trashed_original(info_file):
    date = ""
    path = None
    with open(info_file, encoding="utf-8", errors="replace") as handle:
        for line in handle:
            if line.startswith("Path="):
                path = urllib.parse.unquote(line[5:].strip())
            elif line.startswith("DeletionDate="):
                date = line[13:].strip()
    return path, date


def restore(targets):
    base = trash_base()
    info_directory = os.path.join(base, "info")
    files_directory = os.path.join(base, "files")
    if not os.path.isdir(info_directory):
        return {"created": [], "moved": []}
    entries = []
    for entry in os.listdir(info_directory):
        if not entry.endswith(".trashinfo"):
            continue
        path, date = trashed_original(os.path.join(info_directory, entry))
        if path:
            entries.append((path, date, entry))
    for target in targets:
        target = os.path.abspath(target)
        matches = sorted((item for item in entries if item[0] == target), key=lambda item: item[1])
        if not matches or os.path.lexists(target):
            continue
        entry = matches[-1][2]
        source = os.path.join(files_directory, entry[: -len(".trashinfo")])
        if os.path.lexists(source):
            shutil.move(source, target)
            os.remove(os.path.join(info_directory, entry))
    return {"created": [], "moved": []}


def main():
    if len(sys.argv) < 3:
        sys.exit(2)
    command = sys.argv[1]
    if command == "transfer" and len(sys.argv) >= 4:
        result = transfer(sys.argv[2], sys.argv[3], sys.argv[4:])
    elif command == "zip":
        result = compress(sys.argv[2], sys.argv[3:])
    elif command == "restore":
        result = restore(sys.argv[2:])
    else:
        sys.exit(2)
    print(json.dumps(result))


if __name__ == "__main__":
    main()
