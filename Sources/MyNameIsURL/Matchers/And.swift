import Foundation



/**
 Type that matches a `URL` based on evaluation of its wrapped `URLMatchable`s, logically AND’d together.
 
 Usage:
 ```
 let url = URL(string: "https://example.com/foo")!
 And(Scheme.https, Host("example.com")).matches(url) //> true
 And(Scheme.https, Path("/foo")).matches(url)        //> true
 And(Scheme.https, Path("/not-here")).matches(url)   //> false
 ```
 */
public struct And: URLMatchable {
  private let matchables: [URLMatchable]
  
  
  /**
   Wraps given collection of `URLMatchable`s creating a new `And` value. This matches `URL`s by evaluating these wrapped matchables and logically AND-ing their results together.
   
   - Parameter matchables: The matchables to evaluate and logically AND together to determine the status of a match.
   */
  public init(_ matchables: URLMatchable...) {
    self.init(matchables)
  }
  
  
  /**
   Wraps given collection of `URLMatchable`s creating a new `And` value. This matches `URL`s by evaluating these wrapped matchables and logically AND-ing their results together.
   
   - Parameter matchables: The matchables to evaluate and logically AND together to determine the status of a match.
   */
  public init(_ matchables: [URLMatchable]) {
    precondition(!matchables.isEmpty, "`And` must have at least one predicate.")
    self.matchables = matchables
  }
  
  
  /**
   Predicate that determines whether an `And` matches a given `URL`
   
   - Parameter url: The `URL` to be matched.
   
   - Returns: `true` if the wrapped collection of `URLMatchable`s all evaluate to `true`. Otherwise, `false`.
   */
  public func matches(url: URL) -> Bool {
    return matchables.allSatisfy { $0.matches(url: url) }
  }
}
