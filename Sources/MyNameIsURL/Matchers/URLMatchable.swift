import Foundation



public protocol URLMatchable {
  func matches(url: URL) -> Bool
}



public func ~=(pattern: URLMatchable, value: URL) -> Bool {
  return pattern.matches(url: value)
}
