import Foundation



/**
 Type that matches a `URL` based on comparison with the `URL`’s `host` propery.
 
 Usage:
 ```
 let url = URL(string: "https://example.com")!
 Host("example.com").matches(url)      //> true
 Host(".com").matches(url)             //> false
 ```

 - SeeAlso: `HostSuffix`
*/
public struct Host: URLMatchable {
  private struct Missing: URLMatchable {
    public func matches(url: URL) -> Bool {
      return url.host == nil
    }
  }
  

  /**
   A value that matches a `URL` with a `host` property of `nil`.
   
   Usage:
   ```
   let host = URL(string: "http://example.com")!
   let noHost = URL(string: "http://")!
   Host.missing.matches(url: host)   //> false
   Host.missing.matches(url: noHost) //> true
   ```
   */
  public static let missing: URLMatchable = Missing()
  
  
  private let host: String
  
  
  /**
   Wraps the given string to create a new `Host` value. It matches `URL`s based on their `host` property.
   
   - SeeAlso: `HostSuffix`
   
   - Parameter host: The host to match. It will be compared for equality against `URL`’s `host` property.
   */
  public init(_ host: String) {
    self.host = host
  }
  
  
  /**
   Predicate that determines whether a `Host` matches a given `URL`.
   
   - Parameter url: The `URL` to be matched.
   
   - Returns: `true` if the wrapped host is equivalent to `url.host`. Otherwise, `false`.
   */
  public func matches(url: URL) -> Bool {
    return url.host == host
  }
}
