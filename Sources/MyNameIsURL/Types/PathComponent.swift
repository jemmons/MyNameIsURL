import Foundation



public extension PathPrefix {
  /**
   Represents a path component for use in creating a `PathPrefix`. A path component can be either a `name` (which is matched for equality with the strings of a `URL`’s `pathComponents`) or a `wildcard` (which matches any non-nil value):
   
   ```
   PathPrefix([.name("/"), .wildcard, .name("bar")])
   ```
   
   To reduce noise, `PathComponent` conforms to `ExpressibleByStringLiteral`. So the above can be more simply expressed as:
   
   ```
   PathPrefix(["/", .wildcard, "foo"])
   ```
   
   - SeeAlso: `PathPrefix`
   */
  enum PathComponent {
    /// A path component that matches other path components by string comparison.
    case name(String)
    /// A path component that matches any non-nil path component.
    case wildcard
  }
}



extension PathPrefix.PathComponent: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self = .name(value)
  }
}
