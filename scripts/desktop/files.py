import os
import shutil
import sys
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


def transfer(destination, mode, sources):
    destination = os.path.abspath(destination)
    for source in sources:
        source = os.path.abspath(source)
        name = os.path.basename(source)
        if not os.path.lexists(source):
            continue
        if mode == "move" and os.path.dirname(source) == destination:
            continue
        if os.path.isdir(source) and not os.path.islink(source):
            if destination == source or destination.startswith(source + os.sep):
                continue
            stem, extension = name, ""
        else:
            stem, extension = os.path.splitext(name)
        target = unique_path(destination, stem, extension, copy_label)
        if mode == "move":
            shutil.move(source, target)
        elif os.path.isdir(source) and not os.path.islink(source):
            shutil.copytree(source, target, symlinks=True)
        else:
            shutil.copy2(source, target, follow_symlinks=False)


def compress(destination, source):
    source = os.path.abspath(source)
    name = os.path.basename(source)
    is_directory = os.path.isdir(source)
    stem = name if is_directory else os.path.splitext(name)[0]
    archive = unique_path(os.path.abspath(destination), stem, ".zip", zip_label)
    with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as bundle:
        if not is_directory:
            bundle.write(source, name)
            return
        parent = os.path.dirname(source)
        for root, directories, files in os.walk(source):
            bundle.write(root, os.path.relpath(root, parent))
            for file in files:
                path = os.path.join(root, file)
                bundle.write(path, os.path.relpath(path, parent))


def main():
    if len(sys.argv) < 4:
        sys.exit(2)
    command, destination = sys.argv[1], sys.argv[2]
    if command == "transfer":
        transfer(destination, sys.argv[3], sys.argv[4:])
    elif command == "zip":
        compress(destination, sys.argv[3])
    else:
        sys.exit(2)


if __name__ == "__main__":
    main()
