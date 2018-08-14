import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
 import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id : rectWidget
        height: 300
        width: 400
        color: 'black'

        anchors.top: parent.top
        state: 'hide'

        states: [
            State {
                name: 'hide'

                AnchorChanges {
                    target: rectWidget
                    anchors.left: undefined
                    anchors.right: columnLayoutRect.left
                }
            },

            State {
                name: 'show'

                AnchorChanges {
                    target: rectWidget
                    anchors.left: columnLayoutRect.right
                    anchors.right: undefined
                }
            }
        ]

        transitions: [
            Transition {
                AnchorAnimation {
                    duration: 200
                }
            }
        ]
    }

    Rectangle {
        id : columnLayoutRect

        height: parent.height

        implicitWidth: columnLayout.implicitWidth
        implicitHeight: columnLayout.implicitHeight

        signal toggle

        onToggle:
        {
            console.log("clicked in layout")
            rectWidget.state = rectWidget.state === 'show' ? 'hide' : 'show'
        }

        ColumnLayout{
            id : columnLayout

            VerticalButton {
                id : button1
                checkable: true
                text: "Hello Button Bigger"

                onClicked: {
                    console.log("clicked in button")
                    columnLayoutRect.toggle()
                }
            }

            VerticalButton {
                id : button2
                text: "Hello Button"
            }
        }
    }

    Text {
        id: text1
        anchors.centerIn: parent
    }

    Component.onCompleted: {
        button1.clicked()
    }

    onClosing: {
        console.log("closing event!! override here")
    }
}
