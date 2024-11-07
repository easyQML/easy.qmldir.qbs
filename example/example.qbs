import qbs.FileInfo

import easy as Easy  // (1)!

CppApplication {
	Depends {
		name: 'Qt'
		submodules: ['core', 'gui', 'qml', 'quick']
		versionAtLeast: '6.5'
	}

	Depends { name: 'easy.qmldir' }  // (2)!

	name: 'easy-qmldir-qml-example'

	Qt.qml.importName: 'easy.qmldir.example'  // (3)!
	Qt.qml.importVersion: '1.0'               // (4)!

	easy.qmldir.plugin: undefined  // (5)!

	Group {
		name: 'C++ files'
		prefix: 'src/'
		files: ['**/*.cpp', '**/*.hpp']
	}

	Group {
		name: 'QML files'
		files: ['**']
		prefix: 'qml/'
		Qt.core.resourceSourceBase: 'qml/'
		Qt.core.resourcePrefix: '/qt/qml/'
		fileTags: [
			'qt.core.resource_data',  // (6)!
			'easy.qmldir.inputs'      // (7)!
		]
	}

	Easy.Qmldir {  // (8)!
		Qt.core.resourcePrefix: '/qt/qml/easy/qmldir/example/'
		fileTags: ['qt.core.resource_data']
	}
}
