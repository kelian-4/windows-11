pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import qs
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.common.widgets
import qs.modules.waffle.looks

Item {
    id: root
    Layout.alignment: Qt.AlignTop
    property alias sourceSize: avatar.sourceSize
    property string resolvedSource: ""
    readonly property var candidates: [Directories.userAvatarPathAccountsService, Directories.userAvatarPathRicersAndWeirdSystems, Directories.userAvatarPathRicersAndWeirdSystems2]
    implicitWidth: sourceSize.width
    implicitHeight: sourceSize.height

    onCandidatesChanged: {
        probe.running = false;
        probe.running = true;
    }

    Process {
        id: probe
        running: true
        command: ["sh", "-c", "for f in \"$@\"; do [ -f \"$f\" ] && { printf %s \"$f\"; exit 0; }; done", "sh", ...root.candidates]
        stdout: StdioCollector {
            onStreamFinished: root.resolvedSource = text.trim()
        }
    }

    StyledImage {
        id: avatar
        width: root.width
        height: root.height
        visible: false
        fillMode: Image.PreserveAspectCrop
        source: root.resolvedSource
    }

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeWidth: -1
            fillItem: avatar

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root.width / 2
                radiusY: root.height / 2
                startAngle: 0
                sweepAngle: 360
            }
        }
    }
}
