pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

WidgetCard {
    id: root

    readonly property int maxTasks: size === "large" ? 9 : (size === "medium" ? 5 : 2)
    readonly property var pendingTasks: Todo.list.map((task, index) => ({
                content: task.content,
                done: task.done,
                index: index
            })).filter(task => !task.done)

    widgetId: "todo"
    title: Translation.tr("To Do")
    allowedSizes: ["small", "medium", "large"]

    ColumnLayout {
        anchors.fill: parent
        spacing: 2

        Repeater {
            model: root.pendingTasks.slice(0, root.maxTasks)

            delegate: RowLayout {
                id: taskRow

                required property var modelData

                Layout.fillWidth: true
                spacing: 8

                WBorderlessButton {
                    implicitWidth: 24
                    implicitHeight: 24
                    onClicked: Todo.markDone(taskRow.modelData.index)
                    contentItem: Rectangle {
                        implicitWidth: 16
                        implicitHeight: 16
                        radius: 8
                        color: "transparent"
                        border.width: 1
                        border.color: Looks.colors.subfg
                    }
                }

                WText {
                    Layout.fillWidth: true
                    text: taskRow.modelData.content
                    elide: Text.ElideRight
                }
            }
        }

        WText {
            visible: root.pendingTasks.length === 0
            Layout.fillWidth: true
            text: Translation.tr("All tasks are done")
            color: Looks.colors.subfg
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
