import Foundation



public struct Scheme: URLMatchable {
  private let scheme: String
  
  
  public init(_ scheme: String) {
    self.scheme = scheme
  }
  
  
  public func matches(url: URL) -> Bool {
    return url.scheme == scheme
  }
}
