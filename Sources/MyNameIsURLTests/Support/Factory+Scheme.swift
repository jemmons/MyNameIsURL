import Foundation
import MyNameIsURL



extension Factory {
  enum Scheme {
    static let failing = [
      MyNameIsURL.Scheme("https"),
      MyNameIsURL.Scheme("http:"),
      MyNameIsURL.Scheme("httpx"),
      MyNameIsURL.Scheme("xhttp"),
      MyNameIsURL.Scheme(" http"),
      MyNameIsURL.Scheme("http "),
    ]
    static let success = MyNameIsURL.Scheme("http")
  }
}
