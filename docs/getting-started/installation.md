# Installation

!!! question "Already installed the module?"

	Skip to the [next article](./usage.md).

## Prerequisites

### Qbs

Please, check the [official guide](https://doc.qt.io/qbs/installing.html).

### Qt

This is obvious. Otherwise, you wouldn't need the module at all.

## Download

### via Git

=== "HTTPS"

	```sh
	git clone https://github.com/easyQML/easy.qmldir.qbs.git
	```

=== "SSH"

	```sh
	git clone git@github.com:easyQML/easy.qmldir.qbs.git
	```

### as archive

[Download zip](https://github.com/easyQML/easy.qmldir.qbs/archive/refs/heads/main.zip){ .md-button .md-button--primary }

## Add to your project

As you [would do](https://doc.qt.io/qbs/custom-modules.html) with any other 3rdParty module, just add the search path to your project's root `qbs`-file:

```qml
import qbs

Project {
	qbsSearchPaths: [
		'<path/to/easy.qmldir.qbs/root/folder>'
	]

	// ...
}
```

## Use in Qbs

!!! success "Done with installation?"

	Congrats! Now, you no longer need to write your module definitions by hand. Learn how to control the resulting `qmldir` in the next chapter.
