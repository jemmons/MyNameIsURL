# MyNameIsURL

[![Swift Package](https://img.shields.io/static/v1?label=Swift&message=Package&logo=Swift&color=fa7343&style=flat)](https://github.com/Apple/swift-package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-success)](https://github.com/Carthage/Carthage)
[![Documentation](https://jemmons.github.io/MyNameIsURL/badge.svg)](https://jemmons.github.io/MyNameIsURL/)
[![Tests](https://github.com/jemmons/MyNameIsURL/workflows/master/badge.svg)](https://github.com/jemmons/MyNameIsURL/actions?query=workflow%3A%22master%22)
[![Maintainability](https://api.codeclimate.com/v1/badges/d642e8c25cf64ae74b27/maintainability)](https://codeclimate.com/github/jemmons/MyNameIsURL/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d642e8c25cf64ae74b27/test_coverage)](https://codeclimate.com/github/jemmons/MyNameIsURL/test_coverage)

A package for matching URLs in Swift.

## Table of Contents
* [About](#about)
* [Installation](#installation)
* [API](#api)
* [Contributing](#contributing)
* [License](#license)

## About

`MyNameIsURL` provides a set of structs used to create URL-matching values. These values can be matched against URLs in a pattern context (usually as part of a `switch` or `if case`) or manually by calling their `matches(url:)` predicate:

```swift
include MyNameIsURL
let url = URL(string: "http://example.com")!

switch url {
case Host("example.com"):
  // ...
}

Host("example.com").matches(url: url) //> true
```

A set of logical structs are also provided for complex matching requirements:

```swift
let insecureAdminPattern = And(
  Or(PathPrefix(["/", "admin"]), PathPrefix(["/", "root"])),
  Not(Scheme.https)
)

switch myURL {
case insecureAdminPattern:
  fatalError("Admin credentials are not secure!")
// ...
}
```

## Installation
### Swift Package Manager <a href="https://swift.org/package-manager">ⓘ</a>

#### Using Xcode 11
Xcode 11 [natively supports Swift Packages](https://developer.apple.com/videos/play/wwdc2019/408/). To add `MyNameIsURL` as a dependency:

* Open the package selection sheet (File → Swift Packages → Add Package Dependency…)
* Paste `https://github.com/jemmons/MyNameIsURL.git` into the “Search or enter package…” field and click “Next”. 
* Answer Xcode’s questions about versions and you’re off to the races.

#### Using Package.swift
In your project’s `Package.swift` file… 

* Find or add [a `dependencies` key](https://github.com/apple/swift-package-manager/blob/master/Documentation/Usage.md#define-dependencies) in the `Package` initializer.
* Add [a `.package` entry](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md#package-dependency) there for `MyNameIsURL`, [specifying the version](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md#package-dependency-requirement) you want:

```swift
dependencies: [
    .package(url: "https://github.com/jemmons/MyNameIsURL.git", from: "0.3.0")
]
```

### Carthage <a href="https://github.com/Carthage/Carthage">ⓘ</a>
Ought to work. Try putting this in your `Cartfile`:

```
github "jemmons/MyNameIsURL" ~> 0.3.0
```


## API
Full API documentation [can be found here](https://jemmons.github.io/MyNameIsURL/).

## Contributing
[Pull requests](https://github.com/jemmons/MyNameIsURL/pulls) are welcome! Please keep in mind this is a weekend project, though, so reviews times measured in “*n* of weeks” is to be expected.

Found a bug? Want a feature? [Issues](https://github.com/jemmons/MyNameIsURL/issues) are the way to communicate! Though the same disclaimers around response times apply. Thank you for your patience.

## License
`MyNameIsURL` is released under the MIT license. [See LICENSE](https://github.com/jemmons/MyNameIsURL/blob/master/LICENSE) for details.
