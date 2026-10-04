# CI Status

Commit: 96e2f198e56880f71ae30f112a74ac587325ba6d
Branche: dev
Date: 2026-10-04 08:30:58 UTC
Run: https://github.com/kelian-4/windows-11/actions/runs/37189164866

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


In scripts/colors/random/random_konachan_wall.sh line 12:
        pictures_path=$(source "$config_file" >/dev/null 2>&1; echo "$XDG_PICTURES_DIR")
                               ^------------^ SC1090 (warning): ShellCheck can't follow non-constant source. Use a directive to specify location.


In scripts/colors/random/random_konachan_wall.sh line 25:
CONFIG_DIR="$XDG_CONFIG_HOME/quickshell/$QUICKSHELL_CONFIG_NAME"
^--------^ SC2034 (warning): CONFIG_DIR appears unused. Verify use (or export if used externally).


In scripts/colors/random/random_konachan_wall.sh line 26:
CACHE_DIR="$XDG_CACHE_HOME/quickshell"
^-------^ SC2034 (warning): CACHE_DIR appears unused. Verify use (or export if used externally).


In scripts/colors/random/random_konachan_wall.sh line 27:
STATE_DIR="$XDG_STATE_HOME/quickshell"
^-------^ SC2034 (warning): STATE_DIR appears unused. Verify use (or export if used externally).


In scripts/colors/random/random_osu_wall.sh line 12:
        pictures_path=$(source "$config_file" >/dev/null 2>&1; echo "$XDG_PICTURES_DIR")
                               ^------------^ SC1090 (warning): ShellCheck can't follow non-constant source. Use a directive to specify location.


In scripts/colors/random/random_osu_wall.sh line 25:
CONFIG_DIR="$XDG_CONFIG_HOME/quickshell/$QUICKSHELL_CONFIG_NAME"
^--------^ SC2034 (warning): CONFIG_DIR appears unused. Verify use (or export if used externally).


In scripts/colors/random/random_osu_wall.sh line 26:
CACHE_DIR="$XDG_CACHE_HOME/quickshell"
^-------^ SC2034 (warning): CACHE_DIR appears unused. Verify use (or export if used externally).


In scripts/colors/random/random_osu_wall.sh line 27:
STATE_DIR="$XDG_STATE_HOME/quickshell"
^-------^ SC2034 (warning): STATE_DIR appears unused. Verify use (or export if used externally).


In scripts/keyring/unlock.sh line 19:
eval $(echo -n "${UNLOCK_PASSWORD}" \
     ^-- SC2046 (warning): Quote this to prevent word splitting.


In scripts/images/least-busy-region-venv.sh line 4:
source $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)/bin/activate
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
  https://www.shellcheck.net/wiki/SC1090 -- ShellCheck can't follow non-const...
  https://www.shellcheck.net/wiki/SC2034 -- CACHE_DIR appears unused. Verify ...
  https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word splitt...
```
