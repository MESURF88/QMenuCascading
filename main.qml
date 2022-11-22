import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: window
    width: 680
    height: 480
    visible: true
    title: qsTr("Stack")


    property int g_vis: 0;
    property int g_x: 0;
    property int g_y: 0;
    property int g_idx: 0;
    property variant g_arr_text: ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"];
    Item
    {
        height: parent.height
        width: parent.width
        id: mainItem
        ColumnLayout
        {
            id: mainArea
            height: parent.height
            width: parent.width
            RowLayout
            {
                id: rowArea
                Layout.preferredHeight: parent.height/10
                width: parent.width
                Layout.alignment: Qt.AlignTop

                Repeater
                {
                    z: 1
                    model: ["apples", "oranges", "pears", "bananas", "grapes", "plums", "cherries", "grapefruits", "kiwis"]
                    delegate: Rectangle
                    {
                        color: "red"
                        id: currView
                        width: 70
                        height: 40
                        radius: 2
                        Text { id: currText; text: "Data: " + modelData }
                        TapHandler
                        {
                            onTapped:
                            {
                                g_vis = ( g_vis === 0) ? 1 : 0;
                                g_vis = 1;
                                g_x = currView.x;
                                g_y = currView.y + currView.height;
                                console.log(g_x, g_y,g_vis);
                            }
                        }
                    }
                }


            }

                Menu
                {
                    id: appearance
                    visible: g_vis
                    x: g_x
                    y: g_y
                    z: 2
                    Repeater
                    {
                    model: 10
                    delegate:
                    Rectangle {
                        color: "red"
                        border.color: "black"
                        border.width: 2
                        radius: 2
                        id: currCascade
                        width: 70
                        height: 40
                        Text { text: "I'm item " + index }
                        TapHandler
                        {
                            onTapped:
                            {
                                g_idx = index;
                                g_vis = 0;
                            }
                        }
                    }
                    }
                }

            ToolBar {
                Layout.preferredHeight: 50
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                contentHeight: toolButton.implicitHeight

                ToolButton {
                    id: toolButton
                    text: stackView.depth > 1 ? "\u25C0" : "\u2630"
                    font.pixelSize: Qt.application.font.pixelSize * 1.6
                    onClicked: {
                        if (stackView.depth > 1) {
                            stackView.pop()
                        } else {
                            drawer.open()
                        }
                    }
                }

                Label {
                    text: stackView.currentItem.title + g_arr_text[g_idx]
                    anchors.centerIn: parent
                }
            }

            Drawer {
                id: drawer
                width: window.width * 0.66
                height: window.height
                Column {
                    anchors.fill: parent
                    ItemDelegate {
                        text: qsTr("Page 1")
                        width: parent.width
                        onClicked: {
                            stackView.push("Page1Form.ui.qml")
                            drawer.close()
                        }
                    }
                    ItemDelegate {
                        text: qsTr("Page 2")
                        width: parent.width
                        onClicked: {
                            stackView.push("Page2Form.ui.qml")
                            drawer.close()
                        }
                    }
                }
            }

            StackView {
                Layout.fillHeight: true
                Layout.fillWidth: true
                id: stackView
                initialItem: "HomeForm.ui.qml"
            }

            }
        /*

        */
    }
}
