import Foundation



public extension URL {
  func replacing(scheme: Scheme) -> URL {
    guard var comps = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
      fatalError("URL “\(self.absoluteString)” composed of invalid components.")
    }
    comps.scheme = scheme.value
    guard let newURL = comps.url else {
      fatalError("Valid URL components resulted in invalid URL.")
    }
    return newURL
  }
}
