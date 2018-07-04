import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3

CoverBackground {
    Column {
      anchors.centerIn: parent
      spacing: Theme.paddingSmall
      width: parent.width
      height: parent.height
      Label { text: "Battery" }
      Label { id: batPer; text: "Test" }
      Label { id: batStt; text: "Test" }
      Label { id: batMah; text: "Test" }
    }
    // CoverActionList {
    //     id: coverActions
    //     CoverAction {
    //         iconSource: "image://theme/icon-cover-favorite"
    //         onTriggered: {
    //             console.log("Cover action triggered")
    //         }
    //     }
    // }
    Python {
      id: py
      Component.onCompleted: {
          addImportPath(Qt.resolvedUrl("."));
          importModule("metrics", function() {
            py.setHandler("stat", function(resp) {
              res = resp[0]
              console.log(res);
              batPer.text = "Capacity: " + res["POWER_SUPPLY_CAPACITY"] + "%"
              batStt.text = "Status: " + res["POWER_SUPPLY_STATUS"] + "%"
            });
            py.setHandler("current_now", function(resp) {
              res = resp[0]
              batMah.text = "Amount: " + res + "mAh"
            });
          });
      }
    }
}
