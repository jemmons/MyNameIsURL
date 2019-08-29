import Foundation
import MyNameIsURL



extension Factory {
  enum Password {
    static let success = MyNameIsURL.Password("don't")
    
    static let failures = [
      MyNameIsURL.Password(":"),
      MyNameIsURL.Password("@"),
      MyNameIsURL.Password("don't:"),
      MyNameIsURL.Password("don't@"),
      MyNameIsURL.Password(":don't"),
      MyNameIsURL.Password("@don't"),
      MyNameIsURL.Password(" "),
      MyNameIsURL.Password(""),
      MyNameIsURL.Password(" don't"),
      MyNameIsURL.Password("don't "),
    ]
  }
}
