//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
//@ pragma Env QT_SCALE_FACTOR=1

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Quickshell
import qs.services
import qs.modules.common
import qs.modules.waffle.looks
import qs.modules.waffle.settings

ApplicationWindow {
    id: root

    property int currentPage: 0
    readonly property var pages: SettingsPages.pages
    readonly property bool searching: sidebar.query.trim().length > 0

    visible: true
    title: Translation.tr("Settings")
    flags: Qt.Window | Qt.FramelessWindowHint
    onClosing: Qt.quit()

    width: 1100
    height: 750
    minimumWidth: 750
    minimumHeight: 500
    color: Looks.colors.bg0Base

    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme();
        Config.readWriteDelay = 0;
    }

    Shortcut {
        sequences: ["Ctrl+PgDown", "Ctrl+Tab"]
        onActivated: root.currentPage = (root.currentPage + 1) % root.pages.length
    }

    Shortcut {
        sequences: ["Ctrl+PgUp", "Ctrl+Shift+Tab"]
        onActivated: root.currentPage = (root.currentPage - 1 + root.pages.length) % root.pages.length
    }

    Item {
        anchors.fill: parent

        SettingsTitleBar {
            id: titleBar
            z: 2
            window: root
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            canGoBack: root.searching
            onBackRequested: sidebar.query = ""
        }

        SettingsSidebar {
            id: sidebar
            anchors {
                top: titleBar.bottom
                bottom: parent.bottom
                left: parent.left
            }
            pages: root.pages
            currentIndex: root.currentPage
            onPageSelected: index => {
                sidebar.query = "";
                root.currentPage = index;
            }
        }

        Item {
            id: content
            anchors {
                top: titleBar.bottom
                bottom: parent.bottom
                left: sidebar.right
                right: parent.right
            }

            WText {
                id: pageTitle
                x: 64
                y: 10
                text: root.searching ? Translation.tr("Search results") : root.pages[root.currentPage].name
                font.pixelSize: 28
                font.weight: Looks.font.weight.strong
            }

            Loader {
                id: pageLoader
                anchors {
                    top: pageTitle.bottom
                    topMargin: 16
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                visible: !root.searching
                active: Config.ready
                source: root.pages[root.currentPage].source

                onLoaded: {
                    if (item && item.heroComponent !== undefined)
                        item.heroComponent = root.pages[root.currentPage].hero ? heroComponent : null;
                    fadeIn.restart();
                }

                NumberAnimation {
                    id: fadeIn
                    target: pageLoader
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 160
                    easing.type: Easing.OutCubic
                }
            }

            SearchResultsPage {
                anchors.fill: pageLoader
                visible: root.searching
                query: sidebar.query.trim()
                results: SettingsPages.search(sidebar.query)
                onResultClicked: index => {
                    sidebar.query = "";
                    root.currentPage = index;
                }
            }
        }
    }

    Component {
        id: heroComponent
        SettingsHero {}
    }

    component ResizeEdge: MouseArea {
        required property int edges
        hoverEnabled: true
        onPressed: root.startSystemResize(edges)
    }

    ResizeEdge {
        edges: Qt.LeftEdge
        width: 4
        anchors { top: parent.top; bottom: parent.bottom; left: parent.left; topMargin: 8; bottomMargin: 8 }
        cursorShape: Qt.SizeHorCursor
    }

    ResizeEdge {
        edges: Qt.RightEdge
        width: 4
        anchors { top: parent.top; bottom: parent.bottom; right: parent.right; topMargin: 8; bottomMargin: 8 }
        cursorShape: Qt.SizeHorCursor
    }

    ResizeEdge {
        edges: Qt.BottomEdge
        height: 4
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom; leftMargin: 8; rightMargin: 8 }
        cursorShape: Qt.SizeVerCursor
    }

    ResizeEdge {
        edges: Qt.TopEdge
        height: 3
        anchors { left: parent.left; right: parent.right; top: parent.top; leftMargin: 8; rightMargin: 150 }
        cursorShape: Qt.SizeVerCursor
    }

    ResizeEdge {
        edges: Qt.BottomEdge | Qt.RightEdge
        width: 8
        height: 8
        anchors { right: parent.right; bottom: parent.bottom }
        cursorShape: Qt.SizeFDiagCursor
    }

    ResizeEdge {
        edges: Qt.BottomEdge | Qt.LeftEdge
        width: 8
        height: 8
        anchors { left: parent.left; bottom: parent.bottom }
        cursorShape: Qt.SizeBDiagCursor
    }
}
