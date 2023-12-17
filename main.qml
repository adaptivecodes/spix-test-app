import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

ApplicationWindow {
    objectName: "mainWindow"
    width: 1280
    height: 680
    visible: true
    visibility: Window.Maximized
    title: qsTr("Hello Spix")

    Item {
        objectName: "firstPage"
        id: firstPage
        anchors.fill: parent


        MultiPointTouchArea {
            id: mpta
            anchors.fill: parent
            mouseEnabled: true
            minimumTouchPoints: 1
            maximumTouchPoints: 10

            touchPoints: [
                TouchPoint {
                    id: s0p1
                },
                TouchPoint {
                    id: s0p2
                }
            ]


          //  onTouchUpdated: console.log("Touch")
        }


        PinchArea {
            id: pinch

            // anchors.fill: parent
            onPinchFinished: {
                console.log("PinchArea onPinchFinished" + "\n")
            }
            onPinchStarted: {
                console.log("PinchArea onPinchStarted" + "\n")
            }
            onPinchUpdated: {
                console.log("PinchArea onPinchUpdated" + "\n")
            }
            pinch.target: img
            pinch.maximumScale: 1.0
            pinch.minimumScale: 0.1

            pinch.dragAxis: Pinch.NoDrag
        }

        GridLayout {
            columns: 2
            anchors.horizontalCenter: parent.horizontalCenter

            Label {
                text: "RotateGesture: "
                font.pixelSize: 25
            }
            Row {
                spacing: 20

                Image {
                    objectName: "img"
                    id: img
                    width: 300
                    height: 300
                    source: "2815428.png"

                    PinchHandler {
                        id: pinch2
                        objectName: "2-finger pinch"
                        minimumScale: 0.5
                        maximumScale: 3
                        onGrabChanged: ev => {
                                           console.log(ev)
                                       }
                    }
                    onRotationChanged: rotationTxt.text = Math.round(
                                           rotation * 10) / 10 + "°"
                }

            }
            Row {
                spacing: 20

                Text {
                    id: infoTxt
                    font.pixelSize: 25
                    text: "Image Rotation: "

                }
            }
            Row {
                spacing: 20

                Text {
                    id: rotationTxt
                    font.pixelSize: 50
                    text: "0°"

                }
            }
            Label {
                text: "Tap Gesture: "
                font.pixelSize: 25
            }
            Button {

                id: button
                text: "Press Button"
                onPressAndHold: txt.text = "Button state: Pressed and Hold"
                onPressed: txt.text = "Button state: Pressed"
                onToggled: console.log("TOGGLED")
            }

            Text {
                id: txt
                text: "Button state: "
                font.pixelSize: 25
            }

            CheckBox {
                id: check
                checked: false
            }
            Label {
                text: "Swipe Gesture: "
                font.pixelSize: 25
            }
            Slider {
                id: slider
                from: 0
                value: 50
                to: 100
            }
        }


        Image {
            id: c1
            source:  "cursor.png"
            x: s0p1.x
            y: s0p1.y
            height: 64
            width: 32
            visible: s0p1.pressed

        }

        Image {
            id: c2
            source:  "cursor.png"
            x: s0p2.x
            y: s0p2.y
            height: 64
            width: 32
            visible: s0p2.pressed

        }
    }
}
