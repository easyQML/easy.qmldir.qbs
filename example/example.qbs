import qbs.FileInfo

CppApplication {
	Depends {
		name: 'Qt'
		submodules: ['core', 'gui', 'qml', 'quick']
		versionAtLeast: '6.5'
	}

	Depends { name: 'easy.qmldir' }  // (1)!

	name: 'easy-qmldir-qml-example'

	Qt.qml.importName: 'easy.qmldir.example'  // (2)!
	Qt.qml.importVersion: '1.0'               // (3)!

	easy.qmldir.plugin: undefined  // (4)!

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
			'qt.core.resource_data',  // (5)!
			'easy.qmldir.inputs'      // (6)!
		]
	}

	EasyQmldir {  // (7)!
		Qt.core.resourcePrefix: '/qt/qml/easy/qmldir/example/'
		fileTags: ['qt.core.resource_data']
	}
}
