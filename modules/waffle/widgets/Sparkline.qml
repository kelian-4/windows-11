import QtQuick
import QtQuick.Shapes

Item {
    id: root

    property var values: []
    property color lineColor: "white"

    clip: true

    readonly property var points: {
        const list = root.values;
        if (list.length < 2)
            return [];
        const min = Math.min(...list);
        const max = Math.max(...list);
        const span = max - min === 0 ? 1 : max - min;
        return list.map((value, index) => Qt.point(index / (list.length - 1) * root.width, root.height - (value - min) / span * root.height));
    }

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeWidth: 1.5
            strokeColor: root.lineColor
            fillColor: "transparent"
            joinStyle: ShapePath.RoundJoin

            PathPolyline {
                path: root.points
            }
        }
    }
}
