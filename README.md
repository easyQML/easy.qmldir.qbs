# easy.qmldir for Qbs

[![Made by Ukrainian](https://img.shields.io/static/v1?label=Made%20by&message=Ukrainian&labelColor=1f5fb2&color=fad247&style=flat-square)](https://github.com/GooRoo/ukrainian-shields)
[![License](https://img.shields.io/github/license/easyQML/easy.qmldir.qbs?style=flat-square)](LICENSE)

Never write a [`qmldir`](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html) file manually again! This [Qbs](https://doc.qt.io/qbs/index.html) module generates it automatically.

## Features

1. (Almost) full support of every kind of declaration for [Module Definition `qmldir` Files](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#plugin-declaration).
2. Automatic listing of QML objects and JS resources.
3. Detection of singletons via `pragma Singleton`.

## Example

```qml title="my-plugin.qbs" hl_lines="3 17 23"
DynamicLibrary {
	Depends { name: 'Qt.qml' }
	Depends { name: 'easy.qmldir' }  // depend on the module

	name: 'mega-controls-plugin'

	files: ['src/plugin.h']

	Group {
		name: 'QML files'
		files: [
			'qml/Button.qml',
			'qml/Slider.qml',
			'qml/Toggle.qml',
		]

		fileTags: ['easy.qmldir.inputs']  // tag your QML or JavaScript files
	}

	Qt.qml.importName: 'mega.controls'
	Qt.qml.importVersion: '2.0'

	easy.qmldir.classname: 'mega::ControlsPlugin'  // optionally, specify the class name

	// other qmldir facilities are also available (see below)
}
```

This will produce the following `qmldir` file:
```qmldir
module mega.controls
plugin mega-controls-plugin
classname mega::ControlsPlugin
typeinfo plugins.qmltypes

Button 2.0 Button.qml
Slider 2.0 Slider.qml
Toggle 2.0 Toggle.qml
```

### Looking for more?

Check the [`example`](https://github.com/easyQML/easy.qmldir.qbs/tree/master/example) folder or simply run this from the repository’s root:

```sh
qbs run
```

## Documentation

Check the [documentation](https://easyqml.github.io/easy.qmldir.qbs) for installation and configuration guides.
