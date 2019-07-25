import Foundation



/**
 Conforming types define a predicate capable of matching a given `URL` (or not).
 */
public protocol URLMatchable {
  /**
   A predicate that determines whether a conforming type matches the given `URL`.
   
   - Parameter url: The `URL` to be matched.
   - Returns: `true` if the conforming type matches the given `URL`. Otherwise, `false`.
   */
  func matches(url: URL) -> Bool
}



/**
 Overrides the [Pattern Match Operator](https://docs.swift.org/swift-book/ReferenceManual/Patterns.html#grammar_expression-pattern) to allow a given `URL` to be matched by some `URLMatchable` in context of a `switch`.
 
 Example:
 ```
 switch URL(string: "http://example.com")! {
 case Host("example.com"):
   // ...
 default:
   // ...
 }
 ```
 */
public func ~=(pattern: URLMatchable, value: URL) -> Bool {
  return pattern.matches(url: value)
}
