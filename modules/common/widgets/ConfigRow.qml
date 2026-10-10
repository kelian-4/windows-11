import QtQuick
import QtQuick.Layouts

RowLayout {
    property bool uniform: false
    Layout.fillWidth: true
    spacing: 4
    uniformCellSizes: uniform
}
