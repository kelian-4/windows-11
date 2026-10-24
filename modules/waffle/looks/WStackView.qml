import QtQuick
import QtQuick.Controls
import qs.modules.waffle.looks

StackView {
    id: root
    property real moveDistance: 30
    property int pushDuration: 200
    property list<real> bezierCurve: Looks.transition.easing.bezierCurve.easeIn
    clip: true

    background: null

    pushEnter: Transition {
        XAnimator {
            from: -root.moveDistance
            to: 0
            duration: root.pushDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: root.bezierCurve
        }
    }
    pushExit: Transition {
        XAnimator {
            from: 0
            to: root.moveDistance
            duration: root.pushDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: root.bezierCurve
        }
        PropertyAction {
            property: "visible"
            value: false
        }
    }
    popEnter: Transition {
        XAnimator {
            from: root.moveDistance
            to: 0
            duration: root.pushDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: root.bezierCurve
        }
    }
    popExit: Transition {
        XAnimator {
            from: 0
            to: -root.moveDistance
            duration: root.pushDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: root.bezierCurve
        }
        PropertyAction {
            property: "visible"
            value: false
        }
    }
}
