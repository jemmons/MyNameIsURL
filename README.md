# MyNameIsURL

A package for matching URLs in Swift.

## Table of Contents
* [About](#about)
* [Installation](#installation)
* [Usage](#usage)
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
### Swift Package Manager <a href="https://swift.org/package-manager" style='background-position: center right;background-repeat: no-repeat;background-image: linear-gradient(transparent,transparent),url("data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 12 12%22 width=%2218%22 height=%2218%22%3E%3Cpath fill=%22#fff%22 stroke=%22#36c%22 d=%22M1.5 4.518h5.982V10.5H1.5z%22/%3E %3Cpath fill=%22#36c%22 d=%22M5.765 1H11v5.39L9.427 7.937l-1.31-1.31L5.393 9.35l-2.69-2.688 2.81-2.808L4.2 2.544z%22/%3E%3Cpath fill=%22#fff%22 d=%22M9.995 2.004l.022 4.885L8.2 5.07 5.32 7.95 4.09 6.723l2.882-2.88-1.85-1.852z%22/%3E%3C/svg%3E");padding-right: 18px;'></a>

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

### Carthage <a href="https://github.com/Carthage/Carthage" style='background-position: center right;background-repeat: no-repeat;background-image: linear-gradient(transparent,transparent),url("data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 12 12%22 width=%2218%22 height=%2218%22%3E%3Cpath fill=%22#fff%22 stroke=%22#36c%22 d=%22M1.5 4.518h5.982V10.5H1.5z%22/%3E %3Cpath fill=%22#36c%22 d=%22M5.765 1H11v5.39L9.427 7.937l-1.31-1.31L5.393 9.35l-2.69-2.688 2.81-2.808L4.2 2.544z%22/%3E%3Cpath fill=%22#fff%22 d=%22M9.995 2.004l.022 4.885L8.2 5.07 5.32 7.95 4.09 6.723l2.882-2.88-1.85-1.852z%22/%3E%3C/svg%3E");padding-right: 18px;'></a>
Ought to work. Try putting this in your `Cartfile`:

```
github "jemmons/MyNameIsURL" ~> 0.3.0
```


## Usage
### Host
Wraps a string to later match against a URL’s `host` property.

```swift
let url = URL(string: "http://example.com")!

Host("example.com").matches(url: url) //> true
Host("example").matches(url: url)     //> false
Host("com").matches(url: url)         //> false
```

### HostSuffix
Wraps an array of domain names to later match against the suffix of a URL’s `host`, split into domains.

```swift
let url = URL(string: "http://www.example.com")!

HostSuffix(["com"]).matches(url: url)            //> true
HostSuffix(["example", "com"]).matches(url: url) //> true
HostSuffix(["example"]).matches(url: url)        //> false
```

If validity is required of domain names, the `Domain` type can be used in place of `String`. It will `throw` on invalid input:

```swift
try! HostSuffix([Domain(name: "example"), Domain(name: "com")]).matches(url: url) 
//> true
```

<div style="border-left: 4px solid #fcc; padding-left:1em; margin-top: 1em">
Given `URL.host` is a string, and the `Host` type wraps a string, why does `HostSuffix` wrap an collection of domains? Because matching a host suffix by string is a common security issue.
   
Consider the URL “www.example.com”. We may wish to match only the “example.com” part so we naïvely create a value like `HostSuffix("example.com")`. This looks straight-forward, but also matches “hijackexample.com”. Even if we catch this and use the (easy to overlook) `HostSuffix(".example.com")` we now have a situation where “example.com” doesn’t match because it has no leading `"."`.
   
Requiring an array of domains not only forces us to think through these issues but also has the virtuous property of making the naïve solution the correct one — `HostSuffix(["example", "com"])` matches both “www.example.com” and “example.com” but *does not* match “hijackexample.com”.
</div>

### Path
Wraps a string to later match against a URL’s `path` property.

```swift
let url = URL(string: "http://example.com/foo/bar")!

Path("/foo/bar").matches(url: url) //> true
Path("/foo").matches(url: url)     //> false
```

<div style="border-left: 4px solid #FFF1B9; padding-left:1em; margin-top: 1em">
Note `URL` *always* drops the trailing `"/"` in paths. So a `Path` initialized with a trailing `"/"` will never match:

```swift
let url = URL(string: "http://example.com/foo/")!

Path("/foo").matches(url: url)  //> true
Path("/foo/").matches(url: url) //> false
```
</div>

### PathPrefix
Wraps an array of path components to later be matched against prefixes of `URL`’s `pathComponents`.

<div style="border-left: 4px solid #FFF1B9; padding-left:1em; margin-top: 1em; margin-bottom: 1em;">
In the common case of matching against an absolute `URL`, don’t forget the first element of `pathComponents` is a `"/"`.
</div>

```swift
let url = URL(string: "http://example.com/foo/bar")

PathPrefix(["/", "foo", "bar"]).matches(url: URL) //> true
PathPrefix(["/", "foo"]).matches(url: URL)        //> true
PathPrefix(["/"]).matches(url: URL)               //> true
```

<div style="border-left: 4px solid #fcc; padding-left:1em; margin-top: 1em">
Given the `Path` type matches against `URL.path` why does `PathPrefix` wrap an array and match against `URL.pathComponents`? Because matching a partial path is a common source of bugs.

Consider the URL “example.com/post/edit”. We may wish to match only the “/post” part so we naïvely create a value like `PostPrefix("/post")`. This looks straight-forward, but also matches “example.com/poster/edit”, which is probably not intended.

Requiring an array of path components not only forces us to think through these issues but also has the virtuous property of making the naïve solution the correct one — `PathPrefix(["/", "post"])` matches both “example.com/post/edit” and “example.com/post” but *does not* match “example.com/poster”.
</div>

### Scheme
The `Scheme` type is primarily for representing validated URL schemes (the part before the “:”). It also defines many convenience constants for well-known schemes.

This being a URL matching package, though, it’s also extended to match URLs:

```swift
let url = URL(string: "https://example.com")!
Scheme.https.matches(url: url) //> true
```


### And
Type that wraps a collection of other matchers, logically ANDing them together when matching a URL.

```swift
let pattern = And(
  Scheme.https,
  HostSuffix(["example", "com"]),
  PathPrefix(["/", "foo"])
)

pattern.matches(url: URL(string: "https://example.com/foo/bar")!)  // true
pattern.matches(url: URL(string: "https://example.net/foo/bar")!)  // false
pattern.matches(url: URL(string: "https://example.com/fuzz/bar")!) // false
```

### Or
Type that wraps a collection of other matchers, logically ORing them together when matching a URL.

```swift
let pattern = Or(
  Scheme.https,
  HostSuffix(["example", "com"]),
  PathPrefix(["/", "foo"])
)

pattern.matches(url: URL(string: "https://example.com/foo/bar")!) // true
pattern.matches(url: URL(string: "sms://example.net/foo/bar")!)   // true
pattern.matches(url: URL(string: "ftp://example.com/fuzz/bar")!)  // true
```

### Not
Type that negates the matcher it wraps.

```swift
let url = URL(string: "http://example.com")!

Not(Path("example.com")).matches(url: url) //> false
Not(Path("foo.test")).matches(url: url)    //> true
Not(Scheme.http).matches(url: url)         //> false
Not(Scheme.mailto).matches(url: url)       //> true
```

## Contributing
[Pull requests](https://github.com/jemmons/MyNameIsURL/pulls) are welcome! Please keep in mind this is a weekend project, though, so reviews times measured in “*n* of weeks” is to be expected.

Found a bug? Want a feature? [Issues](https://github.com/jemmons/MyNameIsURL/issues) are the way to communicate! Though the same disclaimers around response times apply. Thank you for your patience.

## License
`MyNameIsURL` is released under the MIT license. [See LICENSE](https://github.com/jemmons/MyNameIsURL/blob/master/LICENSE) for details.