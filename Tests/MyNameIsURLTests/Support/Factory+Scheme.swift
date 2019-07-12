import Foundation
import MyNameIsURL



extension Factory {
  enum Scheme {
    static let failing = [
      MyNameIsURL.Scheme.https,
      try! MyNameIsURL.Scheme("https"),
      try! MyNameIsURL.Scheme("httpx"),
      try! MyNameIsURL.Scheme("xhttp"),
      try! MyNameIsURL.Scheme("one+1"),
    ]
    static let success = MyNameIsURL.Scheme.http
    static let staticSchemes = [
      MyNameIsURL.Scheme.http,
      MyNameIsURL.Scheme.https,
      MyNameIsURL.Scheme.tel,
      MyNameIsURL.Scheme.telprompt,
      MyNameIsURL.Scheme.sms,
      MyNameIsURL.Scheme.mailto,
      MyNameIsURL.Scheme.webcal,
    ]
  }
}
