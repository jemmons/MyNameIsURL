import Foundation



/**
 Type that wraps a validated URL scheme, as per [RFC 3986, §3.1](https://tools.ietf.org/html/rfc3986#section-3.1).
 
 The `value` property of a `Scheme` should be considered safe for use in contexts which require a valid scheme name, as any invalid scheme formulations would be rejected by the contructor.
 */
public struct Scheme: Equatable {
  /// Scheme format errors.
  public enum Format: LocalizedError {
    /// Error thrown when a scheme contains an invalid character. `first` indicates whether the first character was invalid (as it has different rules).
    case invalidCharacter(invalidScheme: String, first: Bool)
    
    public var errorDescription: String? {
      switch self {
      case .invalidCharacter(let s, true):
        return "“\(s)” must have a letter as its first character."
      case .invalidCharacter(let s, false):
        return "“\(s)” can only contain letters, numbers, periods (.), pluses (+), and hyphens (-)."
      }
    }
  }
  
  
  /// Scheme size errors.
  public enum Size: LocalizedError {
    /// Error thrown when for a zero-length scheme.
    case tooSmall
    
    public var errorDescription: String? {
      switch self {
      case .tooSmall:
        return "A scheme must contain at least one character."
      }
    }
  }
  
  
  /// Convienience for http scheme.
  public static let http = try! Scheme("http")
  /// Convienience for https scheme.
  public static let https = try! Scheme("https")
  /// Convienience for tel scheme.
  public static let tel = try! Scheme("tel")
  /// Convienience for telPrompt scheme.
  public static let telprompt = try! Scheme("telprompt")
  /// Convienience for sms scheme.
  public static let sms = try! Scheme("sms")
  /// Convienience for mailto scheme.
  public static let mailto = try! Scheme("mailto")
  /// Convienience for webcal scheme.
  public static let webcal = try! Scheme("webcal")
  /// Convienience for file scheme.
  public static let file = try! Scheme("file")
  /// Convienience for ftp scheme.
  public static let ftp = try! Scheme("ftp")

  
  /// A validated scheme, as per [RFC 3986, §3.1](https://tools.ietf.org/html/rfc3986#section-3.1).
  public let value: String
  
  
  /**
   Creates a `Scheme` value, which holds a validated URL scheme as per [RFC 3986, §3.1](https://tools.ietf.org/html/rfc3986#section-3.1) (or `throw`s trying).
   
   RFC 952 states “Scheme names consist of a sequence of characters beginning with a letter and followed by any combination of letters, digits, plus ("+"), period ("."), or hyphen ("-").” Any given `scheme` incosistent with these rules will cause the initializer to `throw`.
   
   Additionally, the RFC says “An implementation should accept uppercase letters as equivalent to lowercase in scheme names for the sake of robustness but should only produce lowercase scheme names for consistency.” For this reason, the given `scheme` is `lowercased` before validation and storage.
   
   - Parameter scheme: The scheme to be validated. Will be stored `lowercased`. Will throw an error if invalid.
   
   - Throws: `Scheme.Format.invalidCharacter` if `scheme` contains invalid character.
   
     `Scheme.Size.tooSmall` is `scheme` is zero-length.
   */
  public init(_ scheme: String) throws {
    value = try Helper.validateing(scheme: scheme)
  }
}



private enum Helper {
  private static let validFirstCharacters: Set<Character> = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  private static let validCharacters: Set<Character> = validFirstCharacters.union(["+", "-", ".", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"])
  
  /**
   RFC 952 states “Scheme names consist of a sequence of characters beginning with a letter and followed by any combination of letters, digits, plus ("+"), period ("."), or hyphen ("-").”
   
   Additionally, the RFC says “An implementation should accept uppercase letters as equivalent to lowercase in scheme names (e.g., allow "HTTP" as well as "http") for the sake of robustness but should only produce lowercase scheme names for consistency.”
   */
  static func validateing(scheme: String) throws -> String {
    let lowerScheme = scheme.lowercased()

    guard let first = lowerScheme.first else {
      throw Scheme.Size.tooSmall
    }
    guard validFirstCharacters.contains(first) else {
      throw Scheme.Format.invalidCharacter(invalidScheme: lowerScheme, first: true)
    }
    guard lowerScheme.allSatisfy(validCharacters.contains) else {
      throw Scheme.Format.invalidCharacter(invalidScheme: lowerScheme, first: false)
    }
    
    return lowerScheme
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
