# ⚠️  Repo Archive Notice

As of Feb 14, 2023, this component will no longer be updated, since the upstream resource-locker-operator has been deprecated for a while now.
See https://github.com/redhat-cop/resource-locker-operator#deprecation-notice for the deprecation notice for Resource Locker Operator.

We provide component `patch-operator` as a drop-in replacement for component `resource-locker`.
Component `patch-operator` provides a transitional `resource-locker.libjsonnet` component library to facilitate gradually migrating components which create resource patches to use the new `patch-operator.libsonnet` library directly.
See the [migration how-to](https://hub.syn.tools/patch-operator/how-tos/migrate-from-resource-locker.html) to learn more.

# Commodore Component: Resource Locker Operator

This is a [Commodore][commodore] Component for Resource Locker Operator.

This repository is part of Project Syn.
For documentation on Project Syn and this component, see https://syn.tools.

## Documentation

The rendered documentation for this component is available on the [Commodore Components Hub](https://hub.syn.tools/resource-locker).

Documentation for this component is written using [Asciidoc][asciidoc] and [Antora][antora].
It is located in the [docs/](docs) folder.
The [Divio documentation structure](https://documentation.divio.com/) is used to organize its content.

Run the `make docs-serve` command in the root of the project, and then browse to http://localhost:2020 to see a preview of the current state of the documentation.

After writing the documentation, please use the `make docs-vale` command and correct any warnings raised by the tool.

## Contributing and license

This library is licensed under [BSD-3-Clause](LICENSE).
For information about how to contribute see [CONTRIBUTING](CONTRIBUTING.md).

[commodore]: https://syn.tools/commodore/
[asciidoc]: https://asciidoctor.org/
[antora]: https://antora.org/
