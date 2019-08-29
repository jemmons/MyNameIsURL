import Foundation



/**
 Type that matches a `URL` based on comparison with the `URL`’s `port` propery.
 
 Usage:
 ```
 let url = URL(string: "https://example.com:8080")!
 Port(8080).matches(url) //> true
 ```
 */
public struct Port: URLMatchable {
  private struct Missing: URLMatchable {
    public func matches(url: URL) -> Bool {
      return url.port == nil
    }
  }


  /**
   A value that matches a `URL` with a `port` property of `nil`.
   
   Usage:
   ```
   let port = URL(string: "http://example.com:8080")!
   let noPort = URL(string: "http://example.com")!
   Port.missing.matches(url: port)   //> false
   Port.missing.matches(url: noPort) //> true
   ```
   */
  public static let missing: URLMatchable = Missing()


  private let port: Int
  
  
  /**
   Wraps the given number to create a new `Port` value. It matches `URL`s based on their `port` property.
   
   - Parameter port: The port number to match. It will be compared for equality against `URL`’s `port` property.
   */
  public init(_ port: Int) {
    self.port = port
  }
  
  
  /**
   Predicate that determines whether a `Port` matches a given `URL`.
   
   - Parameter url: The `URL` to be matched.
   
   - Returns: `true` if the wrapped port number is equivalent to `url.port`. Otherwise, `false`.
   */
  public func matches(url: URL) -> Bool {
    return url.port == port
  }
}



