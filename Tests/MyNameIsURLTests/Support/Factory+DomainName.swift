import Foundation



extension Factory {
  enum DomainName {
    static let valid = [
      "example",
      "Example",
      "EXAMPLE",
      "37signals",
      "411",
      "meand23",
      "penny-arcade",
    ]

    
    static let invalid = [
      "-example",
      "example-",
      "bad!character",
      "not_technically",
      ".fullyqualified",
      "sub.domain",
      "hanging.",
      "pаypal",
      "mötley",
      " leftpad",
      "killed the",
      "internet ",
      "",
    ]
    
    static let tooLong = "thisisa256characterlongscreamaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaah"
  }
}
