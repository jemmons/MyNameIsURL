import Foundation



/**
 Type that matches a `URL` based on comparison with either the `URL`’s `path` or `pathComponetns` propery, depending on the initializer used.
 
 Usage:
 ```
 let url = URL(string: "http://example.com/foo/bar")!
 Path("/foo/bar").matches(url)          //> true
 Path("/foo").matches(url)              //> false
 ```
 
 - SeeAlso: `PathPrefix`
 */
public struct Path: URLMatchable {
  private struct Missing: URLMatchable {
    func matches(url: URL) -> Bool {
      return url.path == ""
    }
  }
  
  
  /**
   A value that matches a `URL` whose `path` property is an empty string (`""`).
   
   Usage:
   ```
   let path = URL(string: "http://example.com/foo")!
   let slash = URL(string: "http://example.com/")!
   let noPath = URL(string: "http://exmaple.com")!
   Path.missing.matches(url: path)   //> false
   Path.missing.matches(url: slash)  //> false
   Path.missing.matches(url: noPath) //> true
   ```
   */
  public static let missing: URLMatchable = Missing()
  
  
  private let path: String
  
  
  /**
   Wraps the given string to create a new `Path` value. It matches `URL`s based on their `path` property.
   
   The given `path` should not include a trailing slash. Both “http://example.com/foo” and “http://example.com/foo/” have a `path` property of `"/foo"`. Thus `Path("/foo/")` will never match either.

   - SeeAlso: `PathPrefix`
   
   - Parameter path: The path to match. It will be compared for equality against `URL`’s `path` property.
   
     It should not contain a trailing slash (see “Discussion”, above).
   */
  public init(_ path: String) {
    self.path = path
  }
  
  
  /**
   Predicate that determines whether a `Path` matches a given `URL`.
   
   - Parameter url: The `URL` to be matched.
  
   - Returns: `true` if the wrapped path is equivalent to `url.path`. Otherwise, `false`.
   */
  public func matches(url: URL) -> Bool {
    return url.path == path
  }
}
