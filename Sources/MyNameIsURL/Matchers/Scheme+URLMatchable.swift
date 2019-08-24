import Foundation



/**
 Extends `Scheme` to match the `scheme` a URL.
 */
extension Scheme: URLMatchable {
  public static var missing: URLMatchable { Missing() }


  /**
   Predicate that determines whether a `Scheme` matches a given `URL`.
   
   - Parameter url: The `URL` to be matched.
   - Returns: `true` if `Scheme`’s `value` property is equal to `url.scheme`. Otherwise, `false`.
   */
  public func matches(url: URL) -> Bool {
    return url.scheme == value
  }
}



private extension Scheme {
  struct Missing: URLMatchable {
    func matches(url: URL) -> Bool {
      return url.scheme == nil
    }
  }
}
