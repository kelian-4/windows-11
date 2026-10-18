import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.waffle.looks

Item {
    WText {
        x: 21
        y: 8
        text: Translation.tr("Coming soon")
        color: Looks.colors.fg1
        font.pixelSize: Looks.font.pixelSize.xlarger
    }
}
