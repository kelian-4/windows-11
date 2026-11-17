pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks

Loader {
    id: root

    required property var contentItem
    property real padding: Looks.radius.large - Looks.radius.medium
    property bool noSmoothClosing: !Config.options.waffles.tweaks.smootherMenuAnimations
    property bool closeOnFocusLost: true
    signal focusCleared()
    
    property Item anchorItem: parent
    property real visualMargin: 12
    readonly property string side: Looks.barSide
    readonly property bool vertical: Looks.barVertical
    property real ambientShadowWidth: 1

    onFocusCleared: {
        if (!root.closeOnFocusLost) return;
        root.close()
    }

    function grabFocus() { // Doesn't work
        item.grabFocus();
    }

    function close() {
        item.close();
    }

    function updateAnchor() {
        item?.anchor.updateAnchor();
    }

    active: false
    visible: active
    sourceComponent: PopupWindow {
        id: popupWindow
        visible: true
        Component.onCompleted: {
            openAnim.start();
        }

        anchor {
            adjustment: Looks.barPopupAdjustment
            item: root.anchorItem
            gravity: Looks.barPopupEdge
            edges: Looks.barPopupEdge
        }

        HyprlandFocusGrab {
            id: focusGrab
            active: true
            windows: [popupWindow]
            onCleared: root.focusCleared();
        }

        function close() {
            if (root.noSmoothClosing) root.active = false;
            else closeAnim.start();
        }

        function grabFocus() {
            focusGrab.active = true; // Doesn't work
        }

        implicitWidth: realContent.implicitWidth + (root.ambientShadowWidth * 2) + (root.visualMargin * 2)
        implicitHeight: realContent.implicitHeight + (root.ambientShadowWidth * 2) + (root.visualMargin * 2)

        property real sourceEdgeMargin: -(root.vertical ? implicitWidth : implicitHeight)
        PropertyAnimation {
            id: openAnim
            target: popupWindow
            property: "sourceEdgeMargin"
            to: (root.ambientShadowWidth + root.visualMargin)
            duration: 200
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Looks.transition.easing.bezierCurve.easeIn
        }
        SequentialAnimation {
            id: closeAnim
            PropertyAnimation {
                target: popupWindow
                property: "sourceEdgeMargin"
                to: -(root.vertical ? popupWindow.implicitWidth : popupWindow.implicitHeight)
                duration: 150
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Looks.transition.easing.bezierCurve.easeOut
            }
            ScriptAction {
                script: {
                    root.active = false;
                }
            }
        }

        color: "transparent"
        WAmbientShadow {
            target: realContent
        }
        
        Rectangle {
            id: realContent
            z: 1
            anchors {
                left: root.vertical ? (root.side === "left" ? parent.left : undefined) : parent.left
                right: root.vertical ? (root.side === "right" ? parent.right : undefined) : parent.right
                top: root.vertical ? parent.top : (root.side === "top" ? parent.top : undefined)
                bottom: root.vertical ? parent.bottom : (root.side === "bottom" ? parent.bottom : undefined)
                margins: root.ambientShadowWidth + root.visualMargin
                // Opening anim
                leftMargin: root.side === "left" ? popupWindow.sourceEdgeMargin : (root.ambientShadowWidth + root.visualMargin)
                rightMargin: root.side === "right" ? popupWindow.sourceEdgeMargin : (root.ambientShadowWidth + root.visualMargin)
                topMargin: root.side === "top" ? popupWindow.sourceEdgeMargin : (root.ambientShadowWidth + root.visualMargin)
                bottomMargin: root.side === "bottom" ? popupWindow.sourceEdgeMargin : (root.ambientShadowWidth + root.visualMargin)
            }
            color: Looks.colors.bg1Base
            radius: Looks.radius.large

            // test
            implicitWidth: root.contentItem.implicitWidth + (root.padding * 2)
            implicitHeight: root.contentItem.implicitHeight + (root.padding * 2)

            children: [root.contentItem]
        }
    }
}
