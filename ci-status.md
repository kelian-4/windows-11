# CI Status

Commit: 0ce21277249d48a0d13735997070d76e548e91f0
Branche: dev
Date: 2026-09-15 09:34:27 UTC
Run: https://github.com/kelian-4/windows-11/actions/runs/34953204738

| Etape | Resultat |
|---|---|
| JSON traductions | success |
| Syntaxe Python | success |
| ShellCheck | failure |
| Formatage QML | failure |

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

In scripts/keyring/unlock.sh line 19:
eval $(echo -n "${UNLOCK_PASSWORD}" \
     ^-- SC2046 (warning): Quote this to prevent word splitting.


In scripts/images/find-regions-venv.sh line 4:
source $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)/bin/activate
       ^-- SC2046 (warning): Quote this to prevent word splitting.


In scripts/images/text-color-venv.sh line 4:
source $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)/bin/activate
       ^-- SC2046 (warning): Quote this to prevent word splitting.


In scripts/images/least-busy-region-venv.sh line 4:
source $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)/bin/activate
       ^-- SC2046 (warning): Quote this to prevent word splitting.


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


In scripts/thumbnails/thumbgen-venv.sh line 4:
source $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)/bin/activate
       ^-- SC2046 (warning): Quote this to prevent word splitting.

For more information:
  https://www.shellcheck.net/wiki/SC1090 -- ShellCheck can't follow non-const...
  https://www.shellcheck.net/wiki/SC2034 -- CACHE_DIR appears unused. Verify ...
  https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word splitt...
```

## Log complet - Formatage QML
```
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Hyprsunset.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Ai.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Todo.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Brightness.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/ai/AiMessageData.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/ai/AiModel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/ai/MistralApiStrategy.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/ai/OpenAiApiStrategy.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/ai/ApiStrategy.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/ai/GeminiApiStrategy.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/MaterialThemeLoader.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/network/WifiAccessPoint.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Cliphist.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Wallpapers.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Translation.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/LauncherApps.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/ConflictKiller.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/BluetoothStatus.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/HyprlandConfig.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/SongRec.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/AppSearch.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/ResourceUsage.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/TimerService.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/BooruResponseData.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Network.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/GlobalFocusGrab.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Updates.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/LauncherSearch.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Privacy.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/MprisController.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/SystemInfo.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Battery.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/KeyringStorage.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Ydotool.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/GoogleCloud.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Idle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/HyprlandAntiFlashbangShader.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/FirstRunExperience.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Booru.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/TrayService.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/PolkitService.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/LatexRenderer.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Emojis.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/TaskbarApps.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Audio.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/HyprlandData.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/SessionWarnings.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Notifications.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/HyprlandKeybinds.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/EasyEffects.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/Weather.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/HyprlandXkb.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./services/DateTime.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./ReloadPopup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./GlobalStates.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./settings.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./shell.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./killDialog.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./welcome.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/onScreenDisplay/BrightnessOSD.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/onScreenDisplay/VolumeOSD.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/onScreenDisplay/WaffleOSD.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/onScreenDisplay/OSDValue.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/BarMenu.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/WidgetsButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/BarButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/UpdatesButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/BarToolTip.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/TimeButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/SearchButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/WaffleBarContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/SystemButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/StartButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/WaffleBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/tasks/TaskAppButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/tasks/TaskPreview.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/tasks/WindowPreview.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/tasks/Tasks.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/BarPopup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/AppButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/TaskViewButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/tray/Tray.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/tray/TrayButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/tray/TrayOverflowMenu.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/bar/BarIconButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/polkit/WPolkitContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/polkit/WafflePolkit.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/NotificationHeaderButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/WNotificationAppIcon.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/NotificationCenterContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/WSingleNotification.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/FocusFooter.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/SmallBorderedIconButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/SmallBorderedIconAndTextButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/WNotificationGroup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/NotificationPaneContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/DateHeader.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/CalendarWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/WNotificationDismissAnim.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationCenter/WaffleNotificationCenter.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WScrollBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WText.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WSlider.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WBarAttachedPanelContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/Looks.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/BodyRectangle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WRectangularShadowThis.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WTextField.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WStackView.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WBorderlessButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WMenuItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WIndeterminateProgressBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WSwitch.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WChoiceButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/AcrylicButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WFadeLoader.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WListView.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WToolbarIconTabButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WIcons.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WPanelPageColumn.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WMenu.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/AcrylicRectangle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WBorderedButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/FooterRectangle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/FluentIcon.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WRectangularShadow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/CloseButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WToolbar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WUserAvatar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WPanelSeparator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WTextInput.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WProgressBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/VerticalPageIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WToolTip.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WTextWithFixedWidth.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WAmbientShadow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WAppIcon.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WToolbarIconButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WToolbarButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WPane.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WToolbarSeparator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WPopupToolTip.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WToolTipContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WTextButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WToolbarTabBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WPanelIconButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/looks/WMouseAreaButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/startPage/AppCategoryGrid.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/startPage/StartAppButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/startPage/StartPageApps.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/startPage/StartPageContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/startPage/AllAppsGrid.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/startPage/BigAppGrid.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/startPage/StartUserButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/startPage/AggregatedAppCategoryModel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/searchPage/TagStrip.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/searchPage/SearchEntryIcon.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/searchPage/SearchResultButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/searchPage/SearchPageContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/searchPage/SearchResults.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/SearchBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/WaffleStartMenu.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/StartMenuContext.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/startMenu/StartMenuContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/background/WaffleBackground.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/volumeControl/VolumeControl.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/volumeControl/VolumeEntry.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/SectionText.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/nightLight/NightLightControl.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/wifi/WifiControl.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/wifi/WWifiNetworkItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/HeaderRow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/ExpandableChoiceButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/mainPage/MainPageBodyToggles.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/mainPage/MainPageBody.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/mainPage/MainPageBodySliders.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/mainPage/MainPageFooter.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/WaffleActionCenter.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/bluetooth/BluetoothControl.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/bluetooth/BluetoothDeviceItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/toggles/ActionCenterToggleButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/toggles/WNetworkToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/toggles/ActionCenterTogglesDelegateChooser.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/MediaPaneContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/ToggleItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/ActionCenterContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/actionCenter/ActionCenterContext.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/lock/WaffleLock.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/notificationPopup/WaffleNotificationPopup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/screenSnip/WScreenSnip.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/screenSnip/WRectangularSelection.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/screenSnip/WRegionSelectionPanel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/taskView/TaskViewWorkspace.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/taskView/TaskViewContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/taskView/TaskViewWindow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/taskView/WaffleTaskView.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/sessionScreen/WaffleSessionScreen.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/sessionScreen/PowerButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/sessionScreen/WSessionScreenTextButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/waffle/sessionScreen/SessionScreenContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/settings/QuickConfig.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/settings/AdvancedConfig.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/settings/GeneralConfig.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/settings/About.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/settings/BackgroundConfig.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/settings/InterfaceConfig.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/settings/BarConfig.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/settings/ServicesConfig.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/onScreenDisplay/indicators/VolumeIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/onScreenDisplay/indicators/GammaIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/onScreenDisplay/indicators/BrightnessIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/onScreenDisplay/OnScreenDisplay.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/onScreenDisplay/OsdValueIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/ScrollHint.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/ClockWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/UtilButtons.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/BatteryPopup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/weather/WeatherBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/weather/WeatherPopup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/weather/WeatherCard.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/BarGroup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/ClockWidgetPopup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/BarContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/Workspaces.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/HyprlandXkbIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/ActiveWindow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/Resource.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/SysTrayMenuEntry.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/Resources.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/Media.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/SysTrayItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/BatteryIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/StyledPopupValueRow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/ResourcesPopup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/SysTray.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/StyledPopupHeaderRow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/NotificationUnreadCount.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/CircleUtilButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/SysTrayMenu.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/LeftSidebarButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/Bar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/bar/StyledPopup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/onScreenKeyboard/OskContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/onScreenKeyboard/OskKey.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/onScreenKeyboard/OnScreenKeyboard.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/fpsLimiter/FpsLimiterContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/fpsLimiter/FpsLimiter.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/volumeMixer/VolumeMixer.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/OverlayContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/OverlayContext.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/OverlayTaskbar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/floatingImage/FloatingImage.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/Overlay.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/StyledOverlayWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/resources/Resources.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/recorder/Recorder.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/notes/NotesContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/notes/Notes.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/OverlayWidgetDelegateChooser.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/crosshair/CrosshairContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/crosshair/Crosshair.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overlay/OverlayBackground.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/volumeMixer/VolumeDialog.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/volumeMixer/VolumeDialogContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/volumeMixer/AudioDeviceSelectorButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/volumeMixer/VolumeMixerEntry.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/BottomWidgetGroup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/nightLight/NightLightDialog.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/QuickSliders.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/wifiNetworks/WifiDialog.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/wifiNetworks/WifiNetworkItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/calendar/CalendarDayButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/calendar/CalendarHeaderButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/calendar/CalendarWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/CenterWidgetGroup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/bluetoothDevices/BluetoothDialog.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/bluetoothDevices/BluetoothDeviceItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/SidebarRight.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidGameModeToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidScreenSnipToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidBluetoothToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidDarkModeToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidColorPickerToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidEasyEffectsToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidAntiFlashbangToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidNotificationToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidNightLightToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidToggleDelegateChooser.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidIdleInhibitorToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidQuickToggleButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidPowerProfileToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidNetworkToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidCloudflareWarpToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidMicToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidMusicRecognition.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidAudioToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/androidStyle/AndroidOnScreenKeyboardToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/AndroidQuickPanel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/ClassicQuickPanel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/classicStyle/CloudflareWarp.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/classicStyle/NetworkToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/classicStyle/NightLight.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/classicStyle/IdleInhibitor.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/classicStyle/BluetoothToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/classicStyle/EasyEffectsToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/classicStyle/QuickToggleButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/classicStyle/GameMode.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/quickToggles/AbstractQuickPanel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/SidebarRightContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/notifications/NotificationList.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/notifications/NotificationStatusButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/pomodoro/PomodoroWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/pomodoro/PomodoroTimer.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/pomodoro/Stopwatch.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/todo/TaskList.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/todo/TodoItemActionButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarRight/todo/TodoWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/polkit/PolkitContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/polkit/Polkit.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/cheatsheet/CheatsheetKeybindsCategory.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/cheatsheet/ElementTile.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/cheatsheet/Cheatsheet.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/cheatsheet/CheatsheetPeriodicTable.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/cheatsheet/CheatsheetKeybinds.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/wallpaperSelector/WallpaperSelectorContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/wallpaperSelector/WallpaperSelector.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/wallpaperSelector/WallpaperDirectoryItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overview/OverviewWindow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overview/Overview.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overview/SearchWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overview/SearchBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overview/OverviewWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/overview/SearchItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/screenCorners/ScreenCorners.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/screenTranslator/ScreenTranslator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/screenTranslator/ScreenTextOverlay.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/screenTranslator/ScreenTranslatorPanel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/Background.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/weather/WeatherWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/AbstractBackgroundWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/ClockText.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/ClockWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/CookieClock.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/TimeColumn.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/SecondHand.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/HourMarks.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/HourHand.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/MinuteHand.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/CookieQuote.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/dateIndicator/DateIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/dateIndicator/RectangleDate.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/dateIndicator/BubbleDate.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/dateIndicator/RotatingDate.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/minuteMarks/Dots.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/minuteMarks/MinuteMarks.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/minuteMarks/BigHourNumbers.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/minuteMarks/Lines.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/background/widgets/clock/DigitalClock.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/mediaControls/PlayerControl.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/mediaControls/MediaControls.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/lock/Lock.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/lock/LockSurface.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/lock/PasswordChars.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/regionSelector/RectCornersSelectionDetails.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/regionSelector/RegionSelection.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/regionSelector/RegionFunctions.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/regionSelector/CursorGuide.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/regionSelector/OptionsToolbar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/regionSelector/CircleSelectionDetails.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/regionSelector/TargetRegion.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/regionSelector/RegionSelector.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/verticalBar/VerticalBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/verticalBar/Resource.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/verticalBar/VerticalMedia.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/verticalBar/Resources.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/verticalBar/BatteryIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/verticalBar/VerticalBarContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/verticalBar/VerticalClockWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/notificationPopup/NotificationPopup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/translator/LanguageSelectorButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/translator/TextCanvas.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/AiChat.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/aiChat/MessageThinkBlock.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/aiChat/AiMessage.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/aiChat/AttachedFileIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/aiChat/MessageCodeBlock.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/aiChat/MessageTextBlock.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/aiChat/SearchQueryButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/aiChat/AnnotationSourceButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/aiChat/AiMessageControlButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/DescriptionBox.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/anime/BooruResponse.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/anime/BooruImage.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/ApiCommandButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/SidebarLeftContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/Anime.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/ScrollToBottomButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/Translator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/SidebarLeft.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sidebarLeft/ApiInputBoxIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sessionScreen/SessionActionButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/sessionScreen/SessionScreen.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/dock/DockSeparator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/dock/DockButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/dock/DockAppButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/dock/DockApps.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/ii/dock/Dock.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/Icons.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ConfigSelectionArray.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/FlowButtonGroup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/DialogButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/DirectoryIcon.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/WindowDialogSectionHeader.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/Pill.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledScrollBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/CalendarView.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/MaterialShape.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/CustomIcon.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StateOverlay.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledToolTipContent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/Favicon.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/LightDarkPreferenceButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/PointingHandLinkHover.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledDropShadow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/PopupToolTip.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ErrorShakeAnimation.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/MaterialLoadingIndicator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/Toolbar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NotificationListView.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/AppIcon.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledComboBox.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NavigationRail.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/SqueezedAnnotationStyledText.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/MenuButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NotificationAppIcon.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/DragManager.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ClippedProgressBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ContentPage.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/WavyLine.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ContentSubsectionLabel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledSpinBox.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/AddressBreadcrumb.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ButtonGroup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledListView.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/Box.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ToolbarTextField.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledSwitch.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/GroupButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledText.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/WindowDialogButtonRow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ContentSection.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/BoxLayout.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/WindowDialogSeparator.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StateLayer.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ScrollEdgeFade.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledProgressBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/MaterialShapeWrappedMaterialSymbol.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ConfigRow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledToolTip.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/MaterialCookie.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ThumbnailImage.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/RippleButtonWithIcon.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/Graph.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/WindowDialog.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/PagePlaceholder.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ConfigSlider.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NavigationRailExpandButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/SineCookie.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/WindowDialogTitle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledTextInput.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledBlurEffect.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/DashedBorder.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/FadeLoader.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NotificationActionButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NotificationGroupExpandButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/WeekRow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/IconToolbarButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/OptionalMaterialSymbol.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ToolbarTabBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ClippedFilledCircularProgress.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/FullscreenPolkitWindow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NavigationRailButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/MaskMultiEffect.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/MaterialTextField.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/FloatingActionButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledRadioButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/RoundCorner.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/CircularProgress.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledTextArea.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NoticeBox.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/SecondaryTabBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ConfigSwitch.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/AddressBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ConfigSpinBox.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/VerticalButtonGroup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ToolbarTabButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/SelectionGroupButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledRectangle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ButtonMouseArea.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/WindowDialogSlider.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/shapes/example-squircle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/shapes/ShapeCanvas.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/shapes/example.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/FocusedScrollMouseArea.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ToolbarButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NavigationRailTabArray.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledRectangularShadow.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/PointingHandInteraction.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/CliphistImage.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/Revealer.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledFlickable.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/VibrantToolbarButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/SecondaryTabButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledSlider.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/IconAndTextToolbarButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NotificationItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/widgetCanvas/AbstractOverlayWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/widgetCanvas/WidgetCanvas.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/widgetCanvas/AbstractWidget.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/SelectionDialog.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/RippleButton.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/Circle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/NotificationGroup.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/WindowDialogParagraph.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/Colorizer.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/DialogListItem.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/WaveVisualizer.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledImage.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/StyledIndeterminateProgressBar.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/KeyboardKey.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ToolbarPairedFab.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/MaterialSymbol.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/MaterialTextArea.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/widgets/ContentSubsection.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/Appearance.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/panels/lock/LockContext.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/panels/lock/LockScreen.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/utils/TempScreenshotProcess.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/utils/MultiTurnProcess.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/utils/ScreenshotAction.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/utils/ImageDownloaderProcess.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/Images.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/Directories.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/functions/Session.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/functions/ObjectUtils.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/functions/NotificationUtils.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/functions/NumberUtils.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/functions/FileUtils.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/functions/ColorUtils.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/functions/Levendist.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/functions/StringUtils.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/functions/Fuzzy.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/functions/DateUtils.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/Config.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/Persistent.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/hyprland/HyprlandConfigOption.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/LauncherSearchResult.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/AnimatedTabIndexPair.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/IndexModel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/FolderListModelWithHistory.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/IdleInhibitorToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/OnScreenKeyboardToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/MicToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/MusicRecognitionToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/GameModeToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/NetworkToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/AudioToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/AntiFlashbangToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/ColorPickerToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/BluetoothToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/EasyEffectsToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/PowerProfilesToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/QuickToggleModel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/DarkModeToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/ScreenSnipToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/NotificationToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/CloudflareWarpToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/quickToggles/NightLightToggle.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/gCloud/GCloudVision.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/gCloud/GCloudVisionResult.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/gCloud/GCloudApi.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/gCloud/GCloudTranslate.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/AdaptedMaterialScheme.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/NestableObject.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./modules/common/models/WorkspaceModel.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./panelFamilies/PanelLoader.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./panelFamilies/IllogicalImpulseFamily.qml
/home/runner/work/_temp/1f896742-ea39-48c7-850f-448c66b61d65.sh: line 3: qmlformat: command not found
INCORRECT: ./panelFamilies/WaffleFamily.qml
```
