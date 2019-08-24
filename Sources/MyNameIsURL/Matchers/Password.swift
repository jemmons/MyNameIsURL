import Foundation



public struct Password: URLMatchable {
  private struct Missing: URLMatchable {
    func matches(url: URL) -> Bool {
      return url.password == nil
    }
  }
    
  public static let missing: URLMatchable = Missing()
  private let password: String
  
  
  public init(_ password: String ) {
    self.password = password
  }
  
  
  public func matches(url: URL) -> Bool {
    return url.password == password
  }
}
