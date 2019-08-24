import Foundation



public struct User: URLMatchable {
  private struct Missing: URLMatchable {
    func matches(url: URL) -> Bool {
      return url.user == nil
    }
  }
  
  
  public static let missing: URLMatchable = Missing()
  private let user: String
  
  
  public init(_ user: String) {
    self.user = user
  }
  
  
  public func matches(url: URL) -> Bool {
    return url.user == user
  }
}
