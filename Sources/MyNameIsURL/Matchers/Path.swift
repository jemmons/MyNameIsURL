import Foundation



public struct Path: URLMatchable {
  private let pathRepresentation: PathRepresentation
  
  
  public init(_ path: String) {
    pathRepresentation = .string(path)
  }
  
  
  public init(_ components: [String]) {
    pathRepresentation = .components(components)
  }
  
  
  public func matches(url: URL) -> Bool {
    switch pathRepresentation {
    case .string(let path):
      return url.path == path
    
    case .components(let comps):
      return url.pathComponents == comps
    }
  }
}
