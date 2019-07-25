import Foundation
import MyNameIsURL



extension Factory {
  enum Host {
    static let failing = [
      MyNameIsURL.Host(""),
      MyNameIsURL.Host("www"),
      MyNameIsURL.Host("example"),
      MyNameIsURL.Host("com"),
      MyNameIsURL.Host("example.com"),
      MyNameIsURL.Host("www.example"),
      MyNameIsURL.Host("www.example.net"),
      MyNameIsURL.Host("sub.example.com"),
      MyNameIsURL.Host("sub.www.example.com"),
      MyNameIsURL.Host("www.example.com.au"),
      MyNameIsURL.Host("xwww.example.com"),
      MyNameIsURL.Host("www.example.comx"),
      MyNameIsURL.Host(" www.example.com"),
      MyNameIsURL.Host("www.example.com "),
    ]
    static let success = MyNameIsURL.Host("www.example.com")
  }
}
