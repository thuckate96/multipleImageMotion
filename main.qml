import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
import myTimer 1.0

Window {
    visible: true
    width: 640
    height: 480
    id: root
    title: qsTr("Hello World")
    property int numIcon: 0
    property var ind: []
    FileDialog{
        id: myDialog
        nameFilters: ["*.png", "*.jpg", "All file (*)"]
        folder: shortcuts.music+"/bibi_data/characters/thumbnail"
        selectMultiple: openFile.__action
        onAccepted: {
            console.log("You choose: "+myDialog.fileUrls)

            //myModel.append({imgId: "abc"+numIcon})
            var arrUrls = [], listUrl = []
            arrUrls = myDialog.fileUrls
            var featured;
            for(var index = 0; index < arrUrls.length; index++){
                featured = arrUrls[0]
                listUrl.push({src: arrUrls[index]})
            }
            console.log(listUrl)
            myModel.insert(numIcon,{imgId: "icon"+numIcon, listSrc:listUrl, imgFeature: featured})
            for(var j = 0; j < listUrl.length; j++){
                console.log(myModel.get(numIcon).listSrc.get(j).src)
            }
            console.log("count of array: "+myModel.get(numIcon).listSrc.count)
            numIcon++
        }
    }

    Button{
        id: openFile
        text: "Open"
        onClicked: {
            myDialog.open()
            myDialog.selectMultiple
//            moveTimer.stop()
        }
    }

    ListModel{
        id: myModel
        ListElement{
            imgId: ""
            listSrc:[ListElement{src: ""}]
            imgFeature: ""
        }
    }
    ListView{
        model: myModel
        delegate: Rectangle{
            Image {
                id: imgId
                source: imgFeature
                width: 100
                height: 150
                Drag.active: clicked.drag.active
                Drag.hotSpot.x: imgId.x
                Drag.hotSpot.y: imgId.y
                x: root.width/2
                y: root.height/2
                MouseArea{
                    id: clicked
                    anchors.fill: parent
                    drag.target: parent
                    onClicked: {
                        txt.text = ""+imgId
                    }
                }

            }
            Text {
                id: txt
                y: 100
            }


        }
    }
    QTimer{
        id: moveTimer
        interval: 100
        onTimeout: {
            for(var i = 0; i < numIcon; i++){
                if(ind[i] < myModel.get(i).listSrc.count){
                    myModel.set(i,{imgFeature: myModel.get(i).listSrc.get(ind[i]).src})
                    ind[i]++
                } else ind[i] = 0
            }
        }
    }
    Button{
        id: action
        x: 100
        text: "Run"
        onClicked: {
            moveTimer.start()
        }
    }
    Button{
        id: btnStop
        anchors.left: action.right
        text: "stop"
        onClicked: {
            moveTimer.stop()
        }
    }
}
