import Foundation


/**
 Type that matchies a `URL` based on evaluation of its wrapped `URLMatchable`s, logically OR’d together.
 
 Usage:
 ```
 let url = URL(string: "https://example.com/foo")!
 Or(Path("/foo"), Path("/bar")).matches(url)      //> true
 Or(Scheme.http, Scheme.https).matches(url)       //> true
 Or(Host("none.test"), Path("/foo")).matches(url) //> true
 Or(Scheme.http, Path("/not-here")).matches(url)  //> false
 ```
 */
public struct Or: URLMatchable {
  private let matchables: [URLMatchable]
  
  
  /**
   Wraps given collection of `URLMatchable`s creating a new `Or` value. This matches `URL`s by evaluating these wrapped matchables and logically OR-ing their results together.
   
   - Parameter matchables: The matchables to evaluate and logically OR together to determine the status of a match.
   */
  public init(_ matchables: URLMatchable...) {
    self.init(matchables)
  }
  
  
  /**
   Wraps given collection of `URLMatchable`s creating a new `Or` value. This matches `URL`s by evaluating these wrapped matchables and logically OR-ing their results together.
   
   - Parameter matchables: The matchables to evaluate and logically OR together to determine the status of a match.
   */
  public init(_ matchables: [URLMatchable]) {
    precondition(!matchables.isEmpty, "`Or` must have at least one predicate.")
    self.matchables = matchables
  }
  
  
  /**
   Predicate that determines whether an `Or` matches a given `URL`
   
   - Parameter url: The `URL` to be matched.
   
   - Returns: `true` if any of the wrapped collection of `URLMatchable`s evaluates to `true`. Otherwise, `false`.
   */
  public func matches(url: URL) -> Bool {
    return matchables.contains { $0.matches(url: url) }
  }
}
