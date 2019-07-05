import Foundation
import MyNameIsURL



extension Factory {
  enum Host {
    enum FromString {
      static let failing = [
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
    
    
    enum FromComponents {
      static let failing = [
        MyNameIsURL.Host(["www"]),
        MyNameIsURL.Host(["example"]),
        MyNameIsURL.Host(["com"]),
        MyNameIsURL.Host(["example", "com"]),
        MyNameIsURL.Host(["www", "example"]),
        MyNameIsURL.Host(["www", "example", "net"]),
        MyNameIsURL.Host(["sub", "example", "com"]),
        MyNameIsURL.Host(["sub", "www", "example", "com"]),
        MyNameIsURL.Host(["www", "example", "com", "au"]),
        MyNameIsURL.Host(["xwww", "example", "com"]),
        MyNameIsURL.Host(["www", "example", "comx"]),
        MyNameIsURL.Host([" www", "example", "com"]),
        MyNameIsURL.Host(["www", "example", "com "]),
      ]
      static let success = MyNameIsURL.Host(["www", "example", "com"])
    }
    
    
    enum FromDomains {
      static let failing = [
        try! MyNameIsURL.Host([Domain(name: "www")]),
        try! MyNameIsURL.Host([Domain(name: "example")]),
        try! MyNameIsURL.Host([Domain(name: "com")]),
        try! MyNameIsURL.Host([Domain(name: "example"), Domain(name: "com")]),
        try! MyNameIsURL.Host([Domain(name: "www"), Domain(name: "example")]),
        try! MyNameIsURL.Host([Domain(name: "www"), Domain(name: "example"), Domain(name: "net")]),
        try! MyNameIsURL.Host([Domain(name: "sub"), Domain(name: "example"), Domain(name: "com")]),
        try! MyNameIsURL.Host([Domain(name: "sub"), Domain(name: "www"), Domain(name: "example"), Domain(name: "com")]),
        try! MyNameIsURL.Host([Domain(name: "www"), Domain(name: "example"), Domain(name: "com"), Domain(name: "au")]),
        try! MyNameIsURL.Host([Domain(name: "xwww"), Domain(name: "example"), Domain(name: "com")]),
        try! MyNameIsURL.Host([Domain(name: "www"), Domain(name: "example"), Domain(name: "comx")]),
      ]
      static let success = try! MyNameIsURL.Host([Domain(name: "www"), Domain(name: "example"), Domain(name: "com")])
    }
  }
}
