/* Carsai OS — Calamares slideshow (minimal, API 2). */

import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    Timer {
        interval: 20000
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    Slide {
        Image {
            id: logo1
            source: "logo.png"
            width: 220; height: 220
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
        }
        Text {
            anchors.horizontalCenter: logo1.horizontalCenter
            anchors.top: logo1.bottom
            anchors.topMargin: 24
            text: qsTr("Installing Carsai OS...<br/>" +
                       "Windows-style shell, hacker aesthetic.<br/>" +
                       "This runs automatically and takes a few minutes.")
            wrapMode: Text.WordWrap
            width: 620
            horizontalAlignment: Text.Center
            color: "#00e5ff"
            font.family: "monospace"
        }
    }
}
