import Foundation



public struct HostSuffix: URLMatchable {
  private let hostRepresentation: HostRepresentation


  public init(_ host: String) {
    hostRepresentation = .string(host)
  }


  public init(_ hostComponetnts: [String]) {
    hostRepresentation = .components(hostComponetnts)
  }
  
  
  public init(_ domains: [Domain]) {
    hostRepresentation = .domains(domains)
  }
  

  public func matches(url: URL) -> Bool {
    switch hostRepresentation {
    case .string(let hostSuffix):
      return url.host?.hasSuffix(hostSuffix) ?? false
    
    case .components(let compsSuffix):
      return url.host?.hostComponents(limit: compsSuffix.count) == compsSuffix
      
    case .domains(let domainsSuffix):
      return url.host?.hostComponents(limit: domainsSuffix.count) == domainsSuffix.map { $0.name }
    }
  }
}
