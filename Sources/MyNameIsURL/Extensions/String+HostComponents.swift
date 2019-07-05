import Foundation



internal extension String {
  func hostComponents(limit: Int = Int.max) -> [String] {
    return Array(split(separator: ".").suffix(limit).map(String.init))
  }
}
