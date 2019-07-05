import Foundation



public struct Not: URLMatchable {
  private let predicate: URLMatchable
  
  
  public init(_ predicate: URLMatchable) {
    self.predicate = predicate
  }
  
  
  public func matches(url: URL) -> Bool {
    return !predicate.matches(url: url)
  }
}
