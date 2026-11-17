import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks
import Quickshell

PopupWindow {
    id: root

    ///////////////////// Properties ////////////////////
    required property bool tasksHovered
    property var appEntry
    property Item anchorItem

    //////////////////// Functions ////////////////////
    function close() { // Closing doesn't animate, not sure if they're just lazy or it's intentional
        marginBehavior.enabled = false;
        root.visible = false;
    }

    function open() {
        marginBehavior.enabled = true;
        root.visible = true;
    }

    function show(appEntry: var, button: Item) {
        root.appEntry = appEntry;
        root.anchorItem = button;
        root.anchor.updateAnchor();
        root.open();
    }

    ///////////////////// Internals /////////////////////
    readonly property string side: Looks.barSide
    readonly property bool vertical: Looks.barVertical
    property real visualMargin: 12
    property real ambientShadowWidth: 1

    visible: false
    color: "transparent"
    implicitWidth: contentItem.implicitWidth + ambientShadowWidth + (visualMargin * 2)
    implicitHeight: contentItem.implicitHeight + ambientShadowWidth + (visualMargin * 2)
    anchor {
        adjustment: PopupAdjustment.Slide
        item: root.anchorItem
        gravity: Looks.barPopupEdge
        edges: Looks.barPopupEdge
    }

    Timer {
        interval: 250
        running: root.visible && !hoverChecker.containsMouse && !root.tasksHovered
        onTriggered: {
            root.close();
        }
    }

    // Content
    MouseArea {
        id: hoverChecker
        anchors.fill: parent
        hoverEnabled: true

        // Shadow
        WAmbientShadow {
            target: contentItem
        }

        Rectangle {
            id: contentItem
            property real sourceEdgeMargin: root.visible ? (root.ambientShadowWidth + root.visualMargin) : -(root.vertical ? root.implicitWidth : root.implicitHeight)
            Behavior on sourceEdgeMargin {
                id: marginBehavior
                animation: Looks.transition.enter.createObject(this)
            }
            anchors {
                left: root.vertical ? (root.side === "left" ? parent.left : undefined) : parent.left
                right: root.vertical ? (root.side === "right" ? parent.right : undefined) : parent.right
                top: root.vertical ? parent.top : (root.side === "top" ? parent.top : undefined)
                bottom: root.vertical ? parent.bottom : (root.side === "bottom" ? parent.bottom : undefined)
                margins: root.ambientShadowWidth + root.visualMargin
                // Opening anim
                leftMargin: root.side === "left" ? sourceEdgeMargin : (root.ambientShadowWidth + root.visualMargin)
                rightMargin: root.side === "right" ? sourceEdgeMargin : (root.ambientShadowWidth + root.visualMargin)
                topMargin: root.side === "top" ? sourceEdgeMargin : (root.ambientShadowWidth + root.visualMargin)
                bottomMargin: root.side === "bottom" ? sourceEdgeMargin : (root.ambientShadowWidth + root.visualMargin)
            }
            color: Looks.colors.bg1Base
            radius: Looks.radius.large
            clip: true

            // Testing
            implicitHeight: Math.min(158, windowsRow.implicitHeight)
            implicitWidth: windowsRow.implicitWidth

            RowLayout {
                id: windowsRow
                anchors.fill: parent

                Repeater {
                    model: ScriptModel {
                        values: root.appEntry?.toplevels ?? []
                    }
                    delegate: WindowPreview {
                        required property var modelData
                        toplevel: modelData
                    }
                }
            }
        }
    }
}
