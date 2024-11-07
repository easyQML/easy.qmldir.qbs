# Usage in Qbs

Here is a short example. Click on :material-plus-circle: to see the explanation.

```qml title="example/example.qbs" hl_lines="12 19 35 39-42"
---8<--- "example/example.qbs"
```

1. Add a dependency on the `easy.qmldir` module in your product.
2. Don't forget to set the module name via [`Qt.qml.importName`](https://doc.qt.io/qbs/qml-qbsmodules-qt-qml.html#importName-prop).
3. Set the module version using [`Qt.qml.importVersion`](https://doc.qt.io/qbs/qml-qbsmodules-qt-qml.html#importVersion-prop).
4. In this case, the product is not a QML engine extension but an application, so there is no plugin. Disable generation by setting it to `undefined`.
5. Tag with `qt.core.resource_data` to pack QML-files into Qt resources.
6. Tag with `easy.qmldir.inputs` to list the QML-files in the generated `qmldir`.
7. You can use `easy.Qmldir` item to easily grab the generated `qmldir` for further packing into resources (like here) or, for example, for installation via [`#!qml qbs.install: true`](https://doc.qt.io/qbs/qml-qbsmodules-qbs.html#install-prop).

You can run this example yourself! Just go to the module’s root folder and execute:
```sh
qbs run
```

## Output

The resulting `qmldir` looks like this:

```plain title="qmldir"
module easy.qmldir.example
typeinfo plugins.qmltypes

singleton Global 1.0 Global.qml
Main 1.0 Main.qml
```
