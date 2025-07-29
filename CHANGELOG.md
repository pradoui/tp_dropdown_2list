# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.3] - 2024-01-XX

### Fixed
- Fixed horizontal positioning logic to prevent dropdown from overflowing screen width
- Improved boundary detection to keep dropdown within screen limits

## [1.0.2] - 2024-01-XX

### Added
- Customizable hover color for list items via `hoverColor` parameter

### Fixed
- Dropdown now adjusts horizontally when there's insufficient space on the right
- Improved positioning logic to prevent dropdown from overflowing screen boundaries

## [1.0.1] - 2024-01-XX

### Fixed
- Dropdown now opens upward when there's insufficient space below
- TextStyle is now properly applied to all list items
- Improved positioning logic to prevent dropdown from being cut off

## [1.0.0] - 2024-01-XX

### Added
- Initial release of Dropdown2List widget
- Dual category support with custom labels
- Single and multi-select modes
- Smooth animations for opening/closing
- Interactive hover effects
- Fully customizable styling (colors, borders, text styles, dimensions)
- ID-text mapping for data management
- Responsive design with overflow handling
- Checkbox support for multi-select mode
- Callback functions for selection events

### Features
- `Dropdown2List` widget with comprehensive customization options
- Support for two separate item categories
- Animated dropdown with fade and scale effects
- Hover effects on individual items
- Border radius customization
- Custom dropdown icons
- Flexible width and height configuration 