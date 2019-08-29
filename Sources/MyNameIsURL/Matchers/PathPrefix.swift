import Foundation



/**
 Type that matches a `URL` based on the prefix of the `URL`’s `pathComponents` property.
 
 Usage:
 ```
 let url = URL(string: "http://example.com/foo/bar")!
 PathPrefix(["/", "foo", "bar"]).matches(url)     //> true
 PathPrefix(["/", .wildcard, "bar"]).matches(url) //> true
 PathPrefix(["/", "foo"]).matches(url)            //> true
 ```
 
 - SeeAlso: `Path`
 */
public struct PathPrefix: URLMatchable {
  private let pathComponents: [PathComponent]


  /**
   Wraps the given `PathComponent`s to create a new `PathPrefix` value. It matches against prefixes of a `URL`’s `pathComponents` property.

   Given the `Path` type matches against `URL.path` why does `PathPrefix` wrap an array and match against `URL.pathComponetns`? Because matching a partial path is a common source of bugs.
   
   Consider the URL “example.com/foo/bar”. We may wish to match only the “/foo” part so we naïvely create a value like `PostPrefix("/foo")`. This looks straight-forward, but also matches “example.com/foox”. Even if we catch this and use the (easy to overlook) `PostPrefix("/foo/")` we now have a situation where “example.com/foo” doesn’t match because lacks the trailing `"/"`.
   
   Requiring an array of path components not only forces us to think through these issues but also has the virtuous property of making the naïve solution the correct one — `PathPrefix(["/", "foo"])` matches both “example.com/foo/bar” and “example.com/foo” but *does not* match “example.com/foox”.
   
   - SeeAlso: `Path`, `PathPrefix.PathComponent`
   
   - Parameter components: The prefix of the path components to match.
   
     In the common case of matching against an absolute `URL`, don’t forget the first element of path components must be a `"/"`.
   */
  public init(_ pathComponents: [PathComponent]) {
    self.pathComponents = pathComponents
  }


  /**
   Predicate that determines whether a `PathPrefix` matches a given `URL`.
   
   - Parameter url: The `URL` to be matched.
   - Returns: `true` if the wrapped path components are a prefix of `url.pathComponents`. Otherwise, `false`.
   */
  public func matches(url: URL) -> Bool {
    let pathPrefix = url.pathComponents.prefix(pathComponents.count)
    guard pathPrefix.count == pathComponents.count else {
      return false
    }
    
    return zip(pathPrefix, pathComponents).allSatisfy { prefix, component in
      switch component {
      case .name(let name):
        return prefix == name
      case .wildcard:
        return true
      }
    }
  }
}
