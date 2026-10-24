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
    property int currentSub: -1
    readonly property var pages: SettingsPages.pages
    readonly property var page: pages[currentPage]
    readonly property var sub: (currentSub >= 0 && currentSub < page.subs.length) ? page.subs[currentSub] : null
    readonly property bool searching: sidebar.query.trim().length > 0
    readonly property bool inSub: !searching && sub !== null
    readonly property bool showHub: !searching && !inSub && page.kind === "hub"
    readonly property bool showSoon: !searching && !inSub && page.kind === "soon"
    readonly property bool showFile: !searching && (inSub || (page.kind === "page" && !!page.source))
    readonly property string fileSource: inSub ? (sub.source ?? "") : (page.source ?? "")

    function openPage(pageIndex, subIndex) {
        sidebar.query = "";
        root.currentSub = -1;
        root.currentPage = pageIndex;
        root.currentSub = subIndex;
    }

    function goBack() {
        if (root.searching) sidebar.query = "";
        else if (root.currentSub >= 0) root.currentSub = -1;
    }

    visible: true
    title: Translation.tr("Settings")
    flags: Qt.Window | Qt.FramelessWindowHint
    onClosing: Qt.quit()

    width: 1100
    height: 750
    minimumWidth: 1010
    minimumHeight: 590
    color: Looks.colors.bg0Base

    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme();
        Config.readWriteDelay = 0;
    }

    Shortcut {
        sequences: ["Ctrl+PgDown", "Ctrl+Tab"]
        onActivated: root.openPage((root.currentPage + 1) % root.pages.length, -1)
    }

    Shortcut {
        sequences: ["Ctrl+PgUp", "Ctrl+Shift+Tab"]
        onActivated: root.openPage((root.currentPage - 1 + root.pages.length) % root.pages.length, -1)
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
            canGoBack: root.searching || root.currentSub >= 0
            onBackRequested: root.goBack()
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
            onPageSelected: index => root.openPage(index, -1)
        }

        Item {
            id: content
            anchors {
                top: titleBar.bottom
                bottom: parent.bottom
                left: sidebar.right
                right: parent.right
            }

            RowLayout {
                id: pageTitle
                x: 64
                y: 10
                width: content.width - 64 - 24
                spacing: 12

                WText {
                    visible: root.searching || root.inSub
                    Layout.maximumWidth: pageTitle.width * 0.5
                    text: root.searching ? Translation.tr("Search results") : root.page.name
                    elide: Text.ElideRight
                    color: root.searching ? Looks.colors.fg : Looks.colors.fg1
                    font.pixelSize: root.inSub ? 24 : 28
                    font.weight: Looks.font.weight.strong

                    MouseArea {
                        anchors.fill: parent
                        enabled: root.inSub
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.goBack()
                    }
                }

                FluentIcon {
                    visible: root.inSub
                    Layout.alignment: Qt.AlignVCenter
                    icon: "chevron-right"
                    implicitSize: 16
                    color: Looks.colors.fg1
                }

                WText {
                    visible: !root.searching
                    Layout.fillWidth: true
                    text: root.inSub && root.sub ? root.sub.title : root.page.name
                    elide: Text.ElideRight
                    font.pixelSize: root.inSub ? 24 : 28
                    font.weight: Looks.font.weight.strong
                }
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
                visible: root.showFile
                active: Config.ready && root.showFile
                source: root.showFile ? root.fileSource : ""

                onLoaded: {
                    if (!item) return;
                    if (item.heroComponent !== undefined)
                        item.heroComponent = (!root.inSub && root.page.hero) ? heroComponent : null;
                    if (item.footerComponent !== undefined)
                        item.footerComponent = (!root.inSub && root.page.subs.length > 0) ? footerComponent : null;
                }
            }

            SettingsHubPage {
                anchors.fill: pageLoader
                visible: root.showHub
                subs: root.page.subs
                tint: root.page.tint
                onOpened: index => root.openPage(root.currentPage, index)
            }

            SoonPage {
                anchors.fill: pageLoader
                visible: root.showSoon
            }

            SearchResultsPage {
                anchors.fill: pageLoader
                visible: root.searching
                query: sidebar.query.trim()
                results: SettingsPages.search(sidebar.query)
                onResultClicked: (pageIndex, subIndex) => root.openPage(pageIndex, subIndex)
            }
        }
    }

    Component {
        id: heroComponent
        SettingsHero {}
    }

    Component {
        id: footerComponent
        ColumnLayout {
            spacing: 4

            Repeater {
                model: root.page.subs
                delegate: SettingsCard {
                    required property var modelData
                    required property int index
                    icon: modelData.icon
                    iconTint: root.page.tint
                    title: modelData.title
                    subtitle: modelData.subtitle
                    onClicked: root.openPage(root.currentPage, index)
                }
            }
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
