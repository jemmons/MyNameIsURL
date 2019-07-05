import Foundation



public struct Host: URLMatchable {
  private let hostRepresentation: HostRepresentation
  
  
  public init(_ host: String) {
    hostRepresentation = .string(host)
  }
  
  
  public init(_ hostComponents: [String]) {
    hostRepresentation = .components(hostComponents)
  }
  
  
  public init(_ domains: [Domain]) {
    hostRepresentation = .domains(domains)
  }
  
  
  public func matches(url: URL) -> Bool {
    switch hostRepresentation {
    case .string(let host):
      return url.host == host
  
    case .components(let comps):
      return url.host?.hostComponents() == comps
    
    case .domains(let domains):
      return url.host?.hostComponents() == domains.map { $0.name }
    }
  }
}
