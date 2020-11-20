# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Breaking Changes

- Upgrade to v1.0.4 ([#7]).
  This version introduces a new required field `id` in the `patches` array.
  Since the label selector of the operator deployment changes, this needs manual intervention.

## [v1.0.0]
### Added
- Argo CD sync option to skip missing CRDs ([#3])
- Provide `apiVersion` for `ResourceLocker` objects in component API ([#8])

### Changed

- Open source component ([#1])
- Use native Helm chart dependency type ([#6])

### Changed

- Disable Kapitan plugin ([#2])

[Unreleased]: https://github.com/projectsyn/component-resource-locker/compare/v1.0.0...HEAD
[v1.0.0]: https://github.com/projectsyn/component-resource-locker/releases/tag/v1.0.0

[#1]: https://github.com/projectsyn/component-resource-locker/pull/1
[#2]: https://github.com/projectsyn/component-resource-locker/pull/2
[#3]: https://github.com/projectsyn/component-resource-locker/pull/3
[#6]: https://github.com/projectsyn/component-resource-locker/pull/6
[#7]: https://github.com/projectsyn/component-resource-locker/pull/7
[#8]: https://github.com/projectsyn/component-resource-locker/pull/8
