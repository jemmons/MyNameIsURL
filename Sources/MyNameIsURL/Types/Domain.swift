import Foundation



/**
 Type that wraps a validated domain name (as per RFCs [952](https://tools.ietf.org/html/rfc952) and [1123](https://tools.ietf.org/html/rfc1123))
 
 The `name` of a `Domain` value should be considered safe for use in contexts which require a valid domain name, as any invalid domain formulations would be rejected by the contructor.
 */
public struct Domain {
  /// Domain formatting error.
  public enum Format: LocalizedError {
    /// Error received when a given string contains characters which are disallowed in a domain name.
    case invalid(String)
    
    public var errorDescription: String? {
      switch self {
      case .invalid(let s):
        return "“\(s)” contains one or more characters that are invalid in a domain name."
      }
    }
  }
  
  
  /// Domain size error.
  public enum Size: LocalizedError {
    /// Error received when a given string domains too many characters to be used as a domain name.
    case tooLong(String)
    
    public var errorDescription: String? {
      switch self {
      case .tooLong(let s):
        return "“\(s)” is too long for a domain name (domain names should be less than 256 characters long)."
      }
    }
  }
  
  
  /// The validated domain name (as a `String`).
  public let name: String
  
  
  /**
   Creates a new `Domain` value which wraps a validated domain name.
   
   And invalid `name` causes the constructor to `throw`.
   
   - Note:
   The validity of the given `name` is judged by RFCs [952](https://tools.ietf.org/html/rfc952) and [RFC-1123](https://tools.ietf.org/html/rfc1123) which state, in part:
   
     “A ‘name’ (Net, Host, Gateway, or Domain name) is a text string … drawn from the alphabet (A-Z), digits (0-9), minus sign (-) … The first character must be an alpha character. The last character must not be a minus sign.”
   
     and
   
     “The restriction on the first character is relaxed to allow either a letter or a digit. Host software ... SHOULD handle host names of up to 255 characters.”
   
   - Parameter name: The domain name to be wrapped (if validated).
   - Throws: `Domain.Format.invalid(String)` if the given `name` is an invalid domain.
   */
  public init(name: String) throws {
    try Helper.validate(name)
    self.name = name
  }
}



extension Domain: Equatable {
  /**
   Defines whether two `Domains` are equal based on their `name` properties.
   
   - Note:
   RFC 952 states “No distinction is made between upper and lower case.” And so the `name`s’ equality is determined with a case-insensitive compare.
   */
  public static func == (lhs: Domain, rhs: Domain) -> Bool {
    return lhs.name.compare(rhs.name, options: [.caseInsensitive], range: nil, locale: Locale(identifier: "en_US_POSIX")) == .orderedSame
  }
}



private enum Helper {
  private static var invalidCharacters: CharacterSet = {
    let validCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789-")
    return validCharacters.inverted
  }()
  
  
  /**
   “A ‘name’ (Net, Host, Gateway, or Domain name) is a text string … drawn from the alphabet (A-Z), digits (0-9), minus sign (-) … No distinction is made between upper and lower case. The first character must be an alpha character. The last character must not be a minus sign.” –[RFC-952](https://tools.ietf.org/html/rfc952)
   
   “The restriction on the first character is relaxed to allow either a letter or a digit. Host software MUST handle host names of up to 63 characters and SHOULD handle host names of up to 255 characters.” –[RFC-1123](https://tools.ietf.org/html/rfc1123)
   */
  static func validate(_ name: String) throws {
    let hasInvalidCharacters = name.rangeOfCharacter(from: invalidCharacters, options: .literal) != nil
    let startWithDash = name.hasPrefix("-")
    let endWithDash = name.hasSuffix("-")
    
    guard !name.isEmpty && !hasInvalidCharacters && !startWithDash && !endWithDash else {
      throw Domain.Format.invalid(name)
    }
    guard name.count <= 255 else {
      throw Domain.Size.tooLong(name)
    }
  }
}
