import Foundation


/**
 A wrapper for a `URLMatchable` that matches a URL whenever its wrapped value does not.
 
 Usage:
 ```
 let url = URL(string: "http://example.com")!
 Not(Host("example.com")).matches(url) //> false
 Not(Scheme.mailto).matches(url) //> true
 ```
 */
public struct Not: URLMatchable {
  private let matchable: URLMatchable
  
  
  /**
   Creates a `Not` value that wraps the given `URLMatchable`, negating it’s `matches` result.
   
   - Parameter matchable: The `URLMatchable` to be negated.
   */
  public init(_ matchable: URLMatchable) {
    self.matchable = matchable
  }
  
  
  /**
   A predicate that determines whether `Not` matches a given `URL`.
   
   - Parameter url: The `URL` to be matched.
   
   - Returns: `true` if `matches` of the wrapped value returns `false`. Otherwise, `false`.
   
     In other words, `Not` matches is the inverse of its wrapped value.
   */
  public func matches(url: URL) -> Bool {
    return !matchable.matches(url: url)
  }
}
