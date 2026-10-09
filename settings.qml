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

    property int currentIndex: 0
    readonly property var currentPage: SettingsPages.pages[currentIndex]
    readonly property bool searching: sidebar.query.trim().length > 0

    visible: true
    title: "Settings"
    flags: Qt.Window | Qt.FramelessWindowHint
    onClosing: Qt.quit()

    width: 1000
    height: 700
    minimumWidth: 640
    minimumHeight: 480
    color: Looks.colors.bg0Base

    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme();
        Config.readWriteDelay = 0;
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
            pages: SettingsPages.pages
            currentIndex: root.currentIndex
            onPageSelected: index => {
                sidebar.query = "";
                root.currentIndex = index;
            }
        }

        Loader {
            id: pageLoader
            anchors {
                top: titleBar.bottom
                bottom: parent.bottom
                left: sidebar.right
                right: parent.right
            }
            sourceComponent: {
                if (root.searching) return searchComponent;
                if (root.currentPage.id === "system") return systemComponent;
                if (root.currentPage.id === "personalization") return personalizationComponent;
                return genericComponent;
            }
        }
    }

    Component {
        id: systemComponent
        SystemPage {
            title: root.currentPage.name
            cards: root.currentPage.cards
        }
    }

    Component {
        id: personalizationComponent
        PersonalizationPage {
            title: root.currentPage.name
        }
    }

    Component {
        id: genericComponent
        GenericPage {
            title: root.currentPage.name
            cards: root.currentPage.cards
        }
    }

    Component {
        id: searchComponent
        SearchResultsPage {
            query: sidebar.query.trim()
            results: SettingsPages.search(sidebar.query)
        }
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
