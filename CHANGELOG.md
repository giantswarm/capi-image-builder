# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- GCP share images authentication
- PSP needed for affinity assistant
- Split CAPG ubuntu builds into specific steps

## [1.0.9] - 2022-07-20

### Fixed

- Reference `emptyDir` correctly in TriggerTemplate rather than Pipeline

## [1.0.8] - 2022-07-20

### Fixed

- Workspaces name
- RunAfter incorrect name referenced

## [1.0.7] - 2022-07-20

### Fixed

- Dont use bash array for listing versions

## [1.0.6] - 2022-07-20

### Fixed

- Switched to image that includes the tools we need

## [1.0.5] - 2022-07-20

### Fixed

- Use generateName for pipelineruns
- Set shebang for bash scripts

## [1.0.4] - 2022-07-20

### Fixed

- Added required PSPs

## [1.0.3] - 2022-07-19

### Fixed

- Ensure service account credentials are quoted

## [1.0.2] - 2022-07-19

### Fixed

- Typo in trigger templates

## [1.0.1] - 2022-07-19

### Fixed

- Remove invalid `type` property from trigger template params

## [1.0.0] - 2022-07-19

- Initial release

[Unreleased]: https://github.com/giantswarm/capi-image-builder/compare/v1.0.9...HEAD
[1.0.9]: https://github.com/giantswarm/capi-image-builder/compare/v1.0.8...v1.0.9
[1.0.8]: https://github.com/giantswarm/capi-image-builder/compare/v1.0.7...v1.0.8
[1.0.7]: https://github.com/giantswarm/capi-image-builder/compare/v1.0.6...v1.0.7
[1.0.6]: https://github.com/giantswarm/capi-image-builder/compare/v1.0.5...v1.0.6
[1.0.5]: https://github.com/giantswarm/capi-image-builder/compare/v1.0.4...v1.0.5
[1.0.4]: https://github.com/giantswarm/capi-image-builder/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/giantswarm/capi-image-builder/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/giantswarm/capi-image-builder/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/giantswarm/capi-image-builder/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/giantswarm/capi-image-builder/releases/tag/v1.0.0
