import QtQuick
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions
import qs.modules.waffle.looks
import qs.modules.waffle.settings

ContentPage {
    id: root
    forceWidth: true

    Process {
        id: randomWallProc
        property string status: ""
        property string scriptPath: `${Directories.scriptPath}/colors/random/random_konachan_wall.sh`
        command: ["bash", "-c", FileUtils.trimFileProtocol(randomWallProc.scriptPath)]
        stdout: SplitParser {
            onRead: data => {
                const line = data.trim();
                randomWallProc.status = line;
                if (line.startsWith("WALLPAPER_PATH="))
                    Config.options.background.wallpaperPath = line.substring("WALLPAPER_PATH=".length);
            }
        }
    }

    property bool matugenAvailable: false

    Process {
        running: true
        command: ["sh", "-c", "command -v matugen"]
        onExited: (exitCode, exitStatus) => root.matugenAvailable = exitCode === 0
    }

    FileDialog {
        id: wallpaperDialog
        title: Translation.tr("Choose wallpaper")
        currentFolder: `${Directories.pictures}`
        nameFilters: [Translation.tr("Images") + " (*.png *.jpg *.jpeg *.webp *.avif *.bmp *.svg)"]
        onAccepted: Wallpapers.apply(FileUtils.trimFileProtocol(selectedFile.toString()))
    }

    component SmallLightDarkPreferenceButton: RippleButton {
        id: smallLightDarkPreferenceButton
        required property bool dark
        property color colText: toggled ? Looks.colors.accentFg : Looks.colors.fg
        padding: 5
        Layout.fillWidth: true
        toggled: Appearance.m3colors.darkmode === dark
        buttonRadius: Looks.radius.medium
        rippleEnabled: false
        colBackground: Looks.colors.bg2Base
        colBackgroundHover: Looks.colors.bg2Hover
        colBackgroundToggled: Looks.colors.accent
        colBackgroundToggledHover: Looks.colors.accentHover
        onClicked: MaterialThemeLoader.setDarkMode(dark)
        contentItem: Item {
            anchors.centerIn: parent
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 0
                SettingsIcon {
                    Layout.alignment: Qt.AlignHCenter
                    size: 30
                    icon: dark ? "dark-theme" : "weather-sunny"
                    tint: smallLightDarkPreferenceButton.colText
                }
                WText {
                    Layout.alignment: Qt.AlignHCenter
                    text: dark ? Translation.tr("Dark") : Translation.tr("Light")
                    font.pixelSize: Looks.font.pixelSize.normal
                    color: smallLightDarkPreferenceButton.colText
                }
            }
        }
    }

    // Wallpaper selection
    ContentSection {
        icon: "format_paint"
        title: Translation.tr("Wallpaper & Colors")
        Layout.fillWidth: true

        RowLayout {
            Layout.fillWidth: true

            Item {
                implicitWidth: 340
                implicitHeight: 200

                StyledImage {
                    id: wallpaperPreview
                    width: parent.width
                    height: parent.height
                    visible: false
                    fillMode: Image.PreserveAspectCrop
                    source: Config.options.background.wallpaperPath
                    cache: false
                }

                Shape {
                    anchors.fill: parent
                    preferredRendererType: Shape.CurveRenderer

                    ShapePath {
                        strokeWidth: -1
                        fillItem: wallpaperPreview

                        PathRectangle {
                            x: 0
                            y: 0
                            width: wallpaperPreview.width
                            height: wallpaperPreview.height
                            radius: Looks.radius.large
                        }
                    }
                }
            }

            ColumnLayout {
                RippleButtonWithIcon {
                    enabled: !randomWallProc.running
                    visible: Config.options.policies.weeb === 1
                    Layout.fillWidth: true
                    buttonRadius: Looks.radius.medium
                    materialIcon: "ifl"
                    mainText: randomWallProc.running ? Translation.tr("Be patient...") : Translation.tr("Random: Konachan")
                    onClicked: {
                        randomWallProc.scriptPath = `${Directories.scriptPath}/colors/random/random_konachan_wall.sh`;
                        randomWallProc.running = true;
                    }
                    StyledToolTip {
                        text: Translation.tr("Random SFW Anime wallpaper from Konachan\nImage is saved to ~/Pictures/Wallpapers")
                    }
                }
                RippleButtonWithIcon {
                    enabled: !randomWallProc.running
                    visible: Config.options.policies.weeb === 1
                    Layout.fillWidth: true
                    buttonRadius: Looks.radius.medium
                    materialIcon: "ifl"
                    mainText: randomWallProc.running ? Translation.tr("Be patient...") : Translation.tr("Random: osu! seasonal")
                    onClicked: {
                        randomWallProc.scriptPath = `${Directories.scriptPath}/colors/random/random_osu_wall.sh`;
                        randomWallProc.running = true;
                    }
                    StyledToolTip {
                        text: Translation.tr("Random osu! seasonal background\nImage is saved to ~/Pictures/Wallpapers")
                    }
                }
                RippleButtonWithIcon {
                    Layout.fillWidth: true
                    materialIcon: "wallpaper"
                    StyledToolTip {
                        text: Translation.tr("Pick wallpaper image on your system")
                    }
                    onClicked: wallpaperDialog.open()
                    mainContentComponent: Component {
                        RowLayout {
                            spacing: 10
                            WText {
                                font.pixelSize: Looks.font.pixelSize.large
                                text: Translation.tr("Choose file")
                            }
                            RowLayout {
                                spacing: 3
                                KeyboardKey {
                                    key: "Ctrl"
                                }
                                KeyboardKey {
                                    key: Config.options.cheatsheet.superKey ?? "󰖳"
                                }
                                WText {
                                    Layout.alignment: Qt.AlignVCenter
                                    text: "+"
                                }
                                KeyboardKey {
                                    key: "T"
                                }
                            }
                        }
                    }
                }
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    uniformCellSizes: true

                    SmallLightDarkPreferenceButton {
                        Layout.fillHeight: true
                        dark: false
                    }
                    SmallLightDarkPreferenceButton {
                        Layout.fillHeight: true
                        dark: true
                    }
                }
            }
        }

        ContentSubsection {
            title: Translation.tr("Accent color")

            Flow {
                Layout.fillWidth: true
                spacing: 4

                Repeater {
                    model: ["", "#FFB900", "#FF8C00", "#F7630C", "#CA5010", "#DA3B01", "#EF6950", "#D13438", "#FF4343", "#E74856", "#E81123", "#EA005E", "#C30052", "#E3008C", "#BF0077", "#C239B3", "#9A0089", "#0078D4", "#0063B1", "#8E8CD8", "#6B69D6", "#8764B8", "#744DA9", "#B146C2", "#881798", "#0099BC", "#2D7D9A", "#00B7C3", "#038387", "#00B294", "#018574", "#00CC6A", "#10893E", "#7A7574", "#5D5A58", "#68768A", "#515C6B", "#567C73", "#486860", "#498205", "#107C10", "#767676", "#4C4A48", "#69797E", "#4A5459", "#647C64", "#525E54", "#847545", "#7E735F"]

                    delegate: Rectangle {
                        id: swatch
                        required property string modelData
                        readonly property bool selected: Config.options.appearance.palette.accentColor.toLowerCase() === modelData.toLowerCase()
                        width: 36
                        height: 36
                        radius: Looks.radius.medium
                        color: modelData.length > 0 ? modelData : Looks.colors.bg2Base
                        border.width: selected ? 2 : 1
                        border.color: selected ? Looks.colors.fg : Looks.colors.bg2Border

                        WText {
                            anchors.centerIn: parent
                            visible: swatch.modelData.length === 0
                            text: "A"
                            font.pixelSize: Looks.font.pixelSize.larger
                        }

                        FluentIcon {
                            anchors.centerIn: parent
                            visible: swatch.selected && swatch.modelData.length > 0
                            icon: "checkmark"
                            implicitSize: 16
                            color: ColorUtils.isDark(swatch.color) ? "#FFFFFF" : "#000000"
                        }

                        MouseArea {
                            id: swatchMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: Config.options.appearance.palette.accentColor = swatch.modelData

                            StyledToolTip {
                                extraVisibleCondition: false
                                alternativeVisibleCondition: swatchMouse.containsMouse
                                text: swatch.modelData.length === 0 ? Translation.tr("Automatic") : swatch.modelData
                            }
                        }
                    }
                }
            }
        }

        ConfigSelectionArray {
            visible: root.matugenAvailable
            currentValue: Config.options.appearance.palette.type
            onSelected: newValue => {
                Config.options.appearance.palette.type = newValue;
                Quickshell.execDetached(["bash", "-c", `${Directories.wallpaperSwitchScriptPath} --noswitch`]);
            }
            options: [
                {
                    "value": "auto",
                    "displayName": Translation.tr("Auto")
                },
                {
                    "value": "scheme-content",
                    "displayName": Translation.tr("Content")
                },
                {
                    "value": "scheme-expressive",
                    "displayName": Translation.tr("Expressive")
                },
                {
                    "value": "scheme-fidelity",
                    "displayName": Translation.tr("Fidelity")
                },
                {
                    "value": "scheme-fruit-salad",
                    "displayName": Translation.tr("Fruit Salad")
                },
                {
                    "value": "scheme-monochrome",
                    "displayName": Translation.tr("Monochrome")
                },
                {
                    "value": "scheme-neutral",
                    "displayName": Translation.tr("Neutral")
                },
                {
                    "value": "scheme-rainbow",
                    "displayName": Translation.tr("Rainbow")
                },
                {
                    "value": "scheme-tonal-spot",
                    "displayName": Translation.tr("Tonal Spot")
                }
            ]
        }

        ConfigSwitch {
            buttonIcon: "ev_shadow"
            text: Translation.tr("Transparency")
            checked: Config.options.appearance.transparency.enable
            onCheckedChanged: {
                Config.options.appearance.transparency.enable = checked;
            }
        }
    }

    NoticeBox {
        Layout.fillWidth: true
        text: Translation.tr('Not all options are available in this app. You should also check the config file by hitting the "Config file" button on the topleft corner or opening %1 manually.').arg(Directories.shellConfigPath)

        Item {
            Layout.fillWidth: true
        }
        RippleButtonWithIcon {
            id: copyPathButton
            property bool justCopied: false
            Layout.fillWidth: false
            buttonRadius: Looks.radius.medium
            materialIcon: justCopied ? "check" : "content_copy"
            mainText: justCopied ? Translation.tr("Path copied") : Translation.tr("Copy path")
            onClicked: {
                copyPathButton.justCopied = true
                Quickshell.clipboardText = FileUtils.trimFileProtocol(`${Directories.config}/illogical-impulse/config.json`);
                revertTextTimer.restart();
            }

            Timer {
                id: revertTextTimer
                interval: 1500
                onTriggered: {
                    copyPathButton.justCopied = false
                }
            }
        }
    }
}
