# easy.qmldir

Provides facilities to generate [Module Definition `qmldir` Files](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html) automatically.

## Properties

- [`module`](#module): `string`
- [`moduleVersion`](#moduleversion): `string`
- [`optionalPlugin`](#optionalplugin): `bool`
- [`plugin`](#plugin): `string`
- [`pluginPath`](#pluginpath): `string`
- [`classname`](#classname): `string`
- [`typeinfo`](#typeinfo): `string`
- [`depends`](#depends): `stringList`
- [`imports`](#imports): `stringList`
- [`designersupported`](#designersupported): `bool`
- [`prefer`](#prefer): `string`

## Detailed Description

This module takes away the burden of manually writing `qmldir` files for your QML modules. It lists all the files it knows, tagged with an [input tag](#input), in the [Module Definition File](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html), and provides the ability to set values for other fields in that file.

## File Tags

### Input

| Tag                | Auto-tagged patterns     | Description                                     |
| ------------------ | ------------------------ | ----------------------------------------------- |
| easy.qmldir.inputs | `*.qml`, `*.js`, `*.mjs` | Tag your files with it to list them in `qmldir` |

### Output

| Tag                | Description                                   |
| ------------------ | --------------------------------------------- |
| easy.qmldir.qmldir | The generated `qmldir` module definition file |

## Property Documentation

#### `module` {.string-type-prop}

:	Declares the [module identifier](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#module-identifier-declaration) of the QML module using the dotted URI notation. It must match the module’s install path. For example:

	```qml
	easy.qmldir.module: 'org.example'
	```

	**Default:** `Qt.qml.importName` (from the product)

#### `moduleVersion` {.string-type-prop}

:	The version of the format `'x.y'` which will be used to generate [object type declarations](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#object-type-declaration) and [JavaScript resource declarations](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#javascript-resource-declaration). For example:

	```qml
	easy.qmldir.moduleVersion: '1.0'
	```

	??? info "Declaring different versions of the same component?"

		Currently, `easy.qmldir` is not able to list objects with different versions in the resulting `qmldir`, but that maybe changed in future. If you need this, [submit an idea](https://github.com/easyQML/easy.qmldir.qbs/discussions/new?category=ideas)!

	**Default:** `Qt.qml.importVersion` (from the product)

#### `optionalPlugin` {.bool-type-prop}

:	Denotes that the [plugin declaration](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#plugin-declaration) should be optional, i.e., the plugin itself does not contain any relevant code and only serves to load a library it links to. If given, and if any types for the QML module are already available, indicating that the library has been loaded by some other means, QML engine will not load the plugin.

	**Default:** `false`

#### `plugin` {.string-type-prop}

:	Plugin library name. It should match the product name, so usually you don’t need to change it.

	**Default:** `product.name`

#### `pluginPath` {.string-type-prop}

:	An optional path for [plugin declaration](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#plugin-declaration). It’s either:

	- an absolute path to the directory containing the plugin file, or
	- a relative path from the directory containing the qmldir file to the directory containing the plugin file.

	You need to specify this only if the compiled plugin binary and the corresponding `qmldir` are located in different directories.

	**Default:** `undefined`

#### `classname` {.string-type-prop}

:	The class name of the C++ plugin used by the QML module to generate a [plugin classname declaration](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#plugin-classname-declaration). It can contain namespaces, too. For example:

	```qml
	easy.qmldir.classname: 'my::widgets::UiPlugin'
	```

	**Default:** `undefined`

#### `typeinfo` {.string-type-prop}

:	Path to the `*.qmltypes` file to generate a [type description file declaration](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#type-description-file-declaration). Usually, it stays unchanged.

	**Default:** `'plugins.qmltypes'`

#### `depends` {.stringList-type-prop}

:	List of QML module that the current module depends on. It generates [module dependencies declarations](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#module-dependencies-declaration) that are rarely needed but sometimes come in handy. Each item in the list must have the format `<ModuleIdentifier> <Version>`. For example:

	```qml
	easy.qmldir.depends: [
		'MyOtherModule 1.0',
		'org.example.config 2.0',
	]
	```

	**Default:** `[]`

#### `imports` {.stringList-type-prop}

:	List of QML modules that are automatically imported by the engine when you import the current QML module. Each item in the list will generate a [module import declaration](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#module-import-declaration).

	This can be used if you want to extend another module with some new components (or even to override existing ones) but don't want to import both modules everywhere. For example:

	```qml
	easy.qmldir.imports: [
		'QtQuick.Controls',
		'QtQuick.Layouts',
	]
	```

	Optionally, you can specify the version of each module like this:

	```qml
	easy.qmldir.imports: [
		'QtQuick.Controls 2.15',
		'QtQuick.Layouts 1.15',
	]
	```

	You can also use `auto` instead of the version. It means the engine will use the same version as your module’s one. For example, you have a module `mega.controls.future` that extends another module `mega.controls` (and you want to re-export it):

	```qml
	easy.qmldir.imports: [
		'mega.controls auto'
	]
	```

	Now if your `mega.controls.future` has a version `1.0`, it will try to `#!qml import mega.controls 1.0`. And if your module is `2.2`, then it will `#!qml import mega.controls 2.2`, and so on.

	??? warning "Looking for `optional` imports?"

		Qt supports `optional` and `default` imports. For instance, they use them in their `QtQuick.Controls` as following:

		```plain title="QtQuick/Controls/qmldir" hl_lines="7-14"
		module QtQuick.Controls
		linktarget Qt6::qtquickcontrols2plugin
		plugin qtquickcontrols2plugin
		classname QtQuickControls2Plugin
		designersupported
		typeinfo plugins.qmltypes
		optional import QtQuick.Controls.Fusion auto
		optional import QtQuick.Controls.Material auto
		optional import QtQuick.Controls.Imagine auto
		optional import QtQuick.Controls.Universal auto
		optional import QtQuick.Controls.Windows auto
		optional import QtQuick.Controls.macOS auto
		optional import QtQuick.Controls.iOS auto
		default import QtQuick.Controls.Basic auto
		prefer :/qt-project.org/imports/QtQuick/Controls/
		```

		The `easy.qmldir`, however, **does not** support this functionality yet. If you need it, [submit an idea](https://github.com/easyQML/easy.qmldir.qbs/discussions/new?category=ideas)!

	**Default:** `[]`

#### `designersupported` {.bool-type-prop}

:	Set this property to `true` if the plugin is supported by Qt Quick Designer.

	**Default:** `false`

#### `prefer` {.string-type-prop}

:	The path to be used for [preferred path declaration](https://doc.qt.io/qt-6/qtqml-modules-qmldir.html#preferred-path-declaration). For example:

	```qml
	easy.qmldir.prefer: ':/qt/qml/org/example/'
	```

	This is useful when your plugin is distributed as a dynamic library, but QML-files are packed into resources instead of distributing them along with the plugin.

	**Default:** `undefined`
