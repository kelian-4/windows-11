import QtQuick
import QtQuick.Effects
import Quickshell
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks

// Was a Kirigami.Icon (org.kde.kirigami), which isn't installed here.
//
// The Fluent SVGs ship as solid dark-gray fills (#212121) with real
// transparency around the glyph — they're meant to be recolored per
// theme via isMask. Two things were tried and reverted:
//   1. MultiEffect.colorization: multiplies the source color, so a dark
//      source stays dark no matter the target color — icons stayed
//      black on dark backgrounds (unreadable, but at least the right
//      *shape*, which confirmed loading was fine).
//   2. MultiEffect mask (maskEnabled + maskSource): should be the
//      textbook-correct approach, but produced solid white squares —
//      something about that mask/source composition isn't behaving as
//      documented in this setup, not worth more blind debugging.
// Settled on `brightness`, a single simple effect applied directly to
// the one Image that was already proven to load and display correctly:
// push a dark icon to white or a light icon to black depending on the
// target color, which is the only two cases that actually occur here
// (dark-theme fg / light-theme fg). Doesn't handle arbitrary accent
// colors, but covers the real, reported problem.
Item {
    id: root

    required property string icon
    property bool filled: false
    property bool monochrome: true
    property int implicitSize: 20
    property color color: Looks.colors.fg
    property bool animated: true // accepted for API compat; no fade implemented
    property alias source: img.source // some callers override the resolved path directly
    implicitWidth: implicitSize
    implicitHeight: implicitSize

    property bool _useFallback: false

    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
        source: {
            if (root.icon === "")
                return "";
            if (root._useFallback)
                return Quickshell.iconPath(root.icon, "image-missing");
            return `${Looks.iconsPath}/${root.icon}${root.filled ? "-filled" : ""}.svg`;
        }
        onStatusChanged: {
            if (status === Image.Error && !root._useFallback)
                root._useFallback = true;
        }

        layer.enabled: root.monochrome
        layer.effect: MultiEffect {
            brightness: ColorUtils.isDark(root.color) ? -1.0 : 1.0
        }
    }
}
