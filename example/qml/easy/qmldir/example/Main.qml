import QtQuick.Controls

import easy.qmldir.example

ApplicationWindow {
	id: root
	objectName: 'Main Window'

	width: 640
	height: 480
	visible: true
	title: 'easy.qmldir for Qbs'

	Label {
		text: 'Hello from QML'
		anchors.centerIn: parent
		color: Global.textColor
	}
}
