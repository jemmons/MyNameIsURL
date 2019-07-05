import Foundation



public struct PathPrefix: URLMatchable {
  private let pathRepresentation: PathRepresentation


  public init(_ path: String) {
    pathRepresentation = .string(path)
  }


  public init(_ components: [String]) {
    pathRepresentation = .components(components)
  }


  public func matches(url: URL) -> Bool {
    switch pathRepresentation {
    case .string(let pathPrefix):
      return url.path.hasPrefix(pathPrefix)
      
    case .components(let compsPrefix):
      return Array(url.pathComponents.prefix(compsPrefix.count)) == compsPrefix
    }
  }
}
