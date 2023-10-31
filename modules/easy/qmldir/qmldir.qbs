import qbs.FileInfo
import qbs.TextFile

Module {
	additionalProductTypes: ['easy.qmldir.qmldir']

	property string module: product.Qt.qml.importName
	PropertyOptions {
		name: 'module'
		description: 'Module identifier (dotted URI notation) of the module'
	}

	property string moduleVersion: product.Qt.qml.importVersion
	PropertyOptions {
		name: 'moduleVersion'
		description: 'The version used for object type declarations'
	}

	property bool optionalPlugin: false
	PropertyOptions {
		name: 'optionalPlugin'
		description: 'Denotes whether a plugin is optional'
	}

	property string plugin: product.name
	PropertyOptions {
		name: 'plugin'
		description: 'Plugin library name for plugin declaration'
	}

	property string pluginPath
	PropertyOptions {
		name: 'pluginPath'
		description: 'Absolute or relative path to the directory containing the plugin file'
	}

	property string classname
	PropertyOptions {
		name: 'classname'
		description: 'Class name of the C++ plugin used by the module'
	}

	property string typeinfo: 'plugins.qmltypes'
	PropertyOptions {
		name: 'typeinfo'
		description: 'Type description file name'
	}

	property stringList depends: []
	PropertyOptions {
		name: 'depends'
		description: 'List of implicit dependencies of the module'
	}

	property stringList imports: []
	PropertyOptions {
		name: 'imports'
		description: 'List of module imports'
	}

	property bool designersupported: false
	PropertyOptions {
		name: 'designersupported'
		description: 'Set this property if the plugin is supported by Qt Quick Designer'
	}

	property string prefer
	PropertyOptions {
		name: 'prefer'
		description: 'Path used by the QML engine to load any further files for this module'
	}

	FileTagger {
        patterns: ['**.qml', '**.js', '**.mjs']
        fileTags: ['easy.qmldir.inputs']
    }

	Rule {
		multiplex: true
		requiresInputs: false

		inputs: ['easy.qmldir.inputs']

		Artifact {
			filePath: FileInfo.joinPaths(product.buildDirectory, 'qmldir')
			fileTags: ['easy.qmldir.qmldir']
		}

		prepare: /* (project, product, inputs, outputs, input, output, explicitlyDependsOn) => */ {
			var cmd = new JavaScriptCommand()
			cmd.description = 'generating ' + output.fileName + ' for ' + product.easy.qmldir.module
			cmd.highlight = 'codegen'
			cmd.sourceCode = function () {
				function maybeSingleton(filePath) {
					var file = new TextFile(filePath)

					while (!file.atEof()) {
						var line = file.readLine()
						if (/^pragma\s+Singleton\s*$/.test(line)) {
							file.close()
							return 'singleton '
						} else if (/\{/.test(line)) {
							break
						}
					}

					file.close()
					return ''
				}

				function writeList(file, type, list) {
					if (list.length > 0) {
						for (var i in list) {
							file.writeLine(type + ' ' + list[i])
						}
						file.writeLine('')
					}
				}

				var p = product.easy.qmldir

				var file = new TextFile(output.filePath, TextFile.WriteOnly)

				// module identifier declaration
				file.writeLine('module ' + p.module)

				// plugin declaration
				if (p.plugin) {
					file.writeLine(
						(p.optionalPlugin? 'optional ' : '') +
						'plugin ' +
						p.plugin +
						(p.pluginPath? ' ' + p.pluginPath : '')
					)
				}

				// plugin classname declaration
				if (p.classname) {
					file.writeLine('classname ' + p.classname)
				}

				// type description file declaration
				file.writeLine('typeinfo ' + p.typeinfo)

				// Qt Quick Designer support
				if (p.designersupported) {
					file.writeLine('designersupported')
				}
				file.writeLine('')

				// implicit dependencies
				writeList(file, 'depends', p.depends)

				// module import declarations
				writeList(file, 'import', p.imports)

				// preferred path declaration
				if (p.prefer) {
					file.writeLine('prefer ' + p.prefer)
					file.writeLine('')
				}

				// object/resource type declarations
				var resources = inputs['easy.qmldir.inputs']
				for (var i in resources) {
					var r = resources[i]
					if (r.fileName.endsWith('.qml') || r.fileName.endsWith('.js') || r.fileName.endsWith('.mjs')) {
						file.writeLine(
							maybeSingleton(r.filePath) +
							r.completeBaseName + ' ' +
							p.moduleVersion + ' ' +
							r.fileName
						)
					}
				}

				file.close()
			}

			return [cmd]
		}
	}
}
