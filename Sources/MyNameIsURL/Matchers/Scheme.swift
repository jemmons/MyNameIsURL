import Foundation



public struct Scheme: URLMatchable, Equatable {
  public enum Format: LocalizedError {
    case requiredLength
    case invalidFirstCharacter
    case invalidCharacters
    
    
    public var errorDescription: String? {
      switch self {
      case .requiredLength:
        return "A scheme must contain at least one character."
      case .invalidFirstCharacter:
        return "Schemes must have a letter as their first character."
      case .invalidCharacters:
        return "Schemes can only contain letters, numbers, periods (.), pluses (+), and hyphens (-)."
      }
    }
  }
  
  
  public static let http = try! Scheme("http")
  public static let https = try! Scheme("https")
  public static let tel = try! Scheme("tel")
  public static let telprompt = try! Scheme("telprompt")
  public static let sms = try! Scheme("sms")
  public static let mailto = try! Scheme("mailto")
  public static let webcal = try! Scheme("webcal")

  
  public let value: String
  
  
  public init(_ scheme: String) throws {
    value = scheme
    try validate()
  }
  
  
  public func matches(url: URL) -> Bool {
    return url.scheme == value
  }
}



private extension Scheme {
  static let validFirstCharacters: Set<Character> = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  static let validCharacters: Set<Character> = validFirstCharacters.union(["+", "-", ".", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"])
  
  func validate() throws {
    guard let first = value.first else {
      throw Format.requiredLength
    }
    guard Scheme.validFirstCharacters.contains(first) else {
      throw Format.invalidFirstCharacter
    }
    guard (value.allSatisfy { Scheme.validCharacters.contains($0) }) else {
      throw Format.invalidCharacters
    }
  }
}



#if swift(>=4.2)
//
#else
private extension Sequence {
  func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
    return try !contains { try !predicate($0) }
  }
}
#endif
