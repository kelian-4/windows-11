# CI Status

Commit: bdd626fad4c1747125ee103947a5cad7681b8fae
Branche: dev
Date: 2026-11-25 07:29:32 UTC
Run: https://github.com/kelian-4/windows-11/actions/runs/45568525257

| Etape | Resultat |
|---|---|
| JSON traductions | success |
| Syntaxe Python | success |
| ShellCheck | failure |

## Log complet - JSON traductions
```
```

## Log complet - Syntaxe Python
```
scripts/hyprland/hyprconfigurator.py:50: SyntaxWarning: "\{" is an invalid escape sequence. Such sequences will not work in the future. Did you mean "\\{"? A raw string is also an option.
  nested_pattern = '\{'.join(pattern_parts)
```

## Log complet - ShellCheck
```

In scripts/keyring/unlock.sh line 19:
eval $(echo -n "${UNLOCK_PASSWORD}" \
     ^-- SC2046 (warning): Quote this to prevent word splitting.


In scripts/colors/applycolor.sh line 6:
CACHE_DIR="$XDG_CACHE_HOME/quickshell"
^-------^ SC2034 (warning): CACHE_DIR appears unused. Verify use (or export if used externally).


In scripts/colors/applycolor.sh line 25:
colorlist=($colornames)     # Array of color names
           ^---------^ SC2206 (warning): Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In scripts/colors/applycolor.sh line 26:
colorvalues=($colorstrings) # Array of color values
             ^-----------^ SC2206 (warning): Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In scripts/colors/applycolor.sh line 46:
  kill -SIGUSR1 $(pidof kitty)
                ^------------^ SC2046 (warning): Quote this to prevent word splitting.


In scripts/colors/switchwall.sh line 10:
MATUGEN_DIR="$XDG_CONFIG_HOME/matugen"
^---------^ SC2034 (warning): MATUGEN_DIR appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 72:
    local screen_width="$1"
          ^----------^ SC2034 (warning): screen_width appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 73:
    local screen_height="$2"
          ^-----------^ SC2034 (warning): screen_height appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 74:
    local wallpaper_path="$3"
          ^------------^ SC2034 (warning): wallpaper_path appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 200:
    cursorposy_inverted=$((screensizey - cursorposy))
    ^-----------------^ SC2034 (warning): cursorposy_inverted appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 381:
                    set_accent_color $(hyprpicker --no-fancy)
                                     ^----------------------^ SC2046 (warning): Quote this to prevent word splitting.


In scripts/colors/switchwall.sh line 468:
        local imgdir="$(dirname "$imgpath")"
              ^----^ SC2155 (warning): Declare and assign separately to avoid masking return values.


In scripts/colors/switchwall.sh line 469:
        local imgbase="$(basename "$imgpath")"
              ^-----^ SC2155 (warning): Declare and assign separately to avoid masking return values.

For more information:
  https://www.shellcheck.net/wiki/SC2034 -- CACHE_DIR appears unused. Verify ...
  https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word splitt...
  https://www.shellcheck.net/wiki/SC2155 -- Declare and assign separately to ...
```
