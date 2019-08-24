import Foundation



public struct Port: URLMatchable {
  private struct Missing: URLMatchable {
    public func matches(url: URL) -> Bool {
      return url.port == nil
    }
  }


  public static let missing: URLMatchable = Missing()
  private let port: Int
  
  
  public init(_ port: Int) {
    self.port = port
  }
  
  
  public func matches(url: URL) -> Bool {
    return url.port == port
  }
}



