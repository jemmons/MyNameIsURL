import Foundation



public struct Domain {
  public enum Format: LocalizedError {
    case invalid(String)
    
    public var errorDescription: String? {
      switch self {
      case .invalid(let s):
        return "“\(s)” contains one or more characters that are invalid in a domain name."
      }
    }
  }
  
  
  public let name: String
  
  
  public init(name: String) throws {
    guard Helper.isValid(name) else {
      throw Format.invalid(name)
    }
    self.name = name
  }
}



extension Domain: Equatable {
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
  static func isValid(_ name: String) -> Bool {
    let hasInvalidCharacters = name.rangeOfCharacter(from: invalidCharacters, options: .literal) != nil
    let startWithDash = name.hasPrefix("-")
    let endWithDash = name.hasSuffix("-")
    
    return !name.isEmpty && !hasInvalidCharacters && !startWithDash && !endWithDash
  }
}
