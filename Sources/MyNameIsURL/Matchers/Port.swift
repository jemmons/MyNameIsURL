import Foundation



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
  
  
  public init(_ port: Int) {
    self.port = port
  }
  
  
  public func matches(url: URL) -> Bool {
    return url.port == port
  }
}



