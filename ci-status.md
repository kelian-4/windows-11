# CI Status

Commit: e5072e15e167c14b82500fc0750e8d33419f89a1
Branche: dev
Date: 2026-10-24 02:46:45 UTC
Run: https://github.com/kelian-4/windows-11/actions/runs/40055578215

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
scripts/hyprland/hyprconfigurator.py:50: SyntaxWarning: invalid escape sequence '\{'
  nested_pattern = '\{'.join(pattern_parts)
```

## Log complet - ShellCheck
```

In scripts/colors/applycolor.sh line 8:
CACHE_DIR="$XDG_CACHE_HOME/quickshell"
^-------^ SC2034 (warning): CACHE_DIR appears unused. Verify use (or export if used externally).


In scripts/colors/applycolor.sh line 27:
colorlist=($colornames)     # Array of color names
           ^---------^ SC2206 (warning): Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In scripts/colors/applycolor.sh line 28:
colorvalues=($colorstrings) # Array of color values
             ^-----------^ SC2206 (warning): Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In scripts/colors/applycolor.sh line 48:
  kill -SIGUSR1 $(pidof kitty)
                ^------------^ SC2046 (warning): Quote this to prevent word splitting.


In scripts/colors/switchwall.sh line 7:
CONFIG_DIR="$XDG_CONFIG_HOME/quickshell/$QUICKSHELL_CONFIG_NAME"
^--------^ SC2034 (warning): CONFIG_DIR appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 12:
MATUGEN_DIR="$XDG_CONFIG_HOME/matugen"
^---------^ SC2034 (warning): MATUGEN_DIR appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 54:
    local screen_width="$1"
          ^----------^ SC2034 (warning): screen_width appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 55:
    local screen_height="$2"
          ^-----------^ SC2034 (warning): screen_height appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 56:
    local wallpaper_path="$3"
          ^------------^ SC2034 (warning): wallpaper_path appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 182:
    cursorposy_inverted=$((screensizey - cursorposy))
    ^-----------------^ SC2034 (warning): cursorposy_inverted appears unused. Verify use (or export if used externally).


In scripts/colors/switchwall.sh line 363:
                    set_accent_color $(hyprpicker --no-fancy)
                                     ^----------------------^ SC2046 (warning): Quote this to prevent word splitting.


In scripts/colors/switchwall.sh line 450:
        local imgdir="$(dirname "$imgpath")"
              ^----^ SC2155 (warning): Declare and assign separately to avoid masking return values.


In scripts/colors/switchwall.sh line 451:
        local imgbase="$(basename "$imgpath")"
              ^-----^ SC2155 (warning): Declare and assign separately to avoid masking return values.


In scripts/keyring/unlock.sh line 19:
eval $(echo -n "${UNLOCK_PASSWORD}" \
     ^-- SC2046 (warning): Quote this to prevent word splitting.


In scripts/images/text-color-venv.sh line 4:
source $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)/bin/activate
       ^-- SC2046 (warning): Quote this to prevent word splitting.


In scripts/images/find-regions-venv.sh line 4:
source $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)/bin/activate
       ^-- SC2046 (warning): Quote this to prevent word splitting.


In scripts/thumbnails/thumbgen-venv.sh line 4:
source $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)/bin/activate
       ^-- SC2046 (warning): Quote this to prevent word splitting.

For more information:
  https://www.shellcheck.net/wiki/SC2034 -- CACHE_DIR appears unused. Verify ...
  https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word splitt...
  https://www.shellcheck.net/wiki/SC2155 -- Declare and assign separately to ...
```
