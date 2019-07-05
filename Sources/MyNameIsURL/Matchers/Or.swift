import Foundation



public struct Or: URLMatchable {
  private let predicates: [URLMatchable]
  
  
  public init(_ predicates: URLMatchable...) {
    self.init(predicates)
  }
  
  
  public init(_ predicates: [URLMatchable]) {
    precondition(!predicates.isEmpty, "`Or` must have at least one predicate.")
    self.predicates = predicates
  }
  
  
  public func matches(url: URL) -> Bool {
    return predicates.contains { $0.matches(url: url) }
  }
}
