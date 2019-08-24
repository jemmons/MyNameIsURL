import Foundation
import MyNameIsURL


extension Factory {
  enum User {
    static let success = MyNameIsURL.User("please")
    
    static let failures = [
      MyNameIsURL.User(":"),
      MyNameIsURL.User("@"),
      MyNameIsURL.User("please:"),
      MyNameIsURL.User("please@"),
      MyNameIsURL.User(":please"),
      MyNameIsURL.User("@please"),
      MyNameIsURL.User(" "),
      MyNameIsURL.User(""),
      MyNameIsURL.User(" please"),
      MyNameIsURL.User("please "),
    ]
  }
}
