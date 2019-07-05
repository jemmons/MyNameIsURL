import Foundation
import MyNameIsURL



extension Factory {
  enum HostSuffix {
    enum FromString {
      static let failing = [
        MyNameIsURL.HostSuffix("example"),
        MyNameIsURL.HostSuffix("."),
        MyNameIsURL.HostSuffix("xcom"),
        MyNameIsURL.HostSuffix("x.com"),
        MyNameIsURL.HostSuffix("comx"),
        MyNameIsURL.HostSuffix("www"),
        MyNameIsURL.HostSuffix(".com "),
        MyNameIsURL.HostSuffix(" .com"),
        MyNameIsURL.HostSuffix("xwww.example.com"),
        MyNameIsURL.HostSuffix("www.example.comx"),
      ]
      
      
      static let success = [
        MyNameIsURL.HostSuffix(""),
        MyNameIsURL.HostSuffix("m"),
        MyNameIsURL.HostSuffix("com"),
        MyNameIsURL.HostSuffix(".com"),
        MyNameIsURL.HostSuffix("example.com"),
        MyNameIsURL.HostSuffix(".example.com"),
        MyNameIsURL.HostSuffix("www.example.com"),
      ]
    }
    
    
    enum FromComponents {
      static let failing = [
        MyNameIsURL.HostSuffix(["example"]),
        MyNameIsURL.HostSuffix(["com", "example"]),
        MyNameIsURL.HostSuffix(["x", "com"]),
        MyNameIsURL.HostSuffix(["m"]),
        MyNameIsURL.HostSuffix(["om"]),
        MyNameIsURL.HostSuffix(["comx"]),
        MyNameIsURL.HostSuffix(["www"]),
        MyNameIsURL.HostSuffix(["xwww", "example", "com"]),
        MyNameIsURL.HostSuffix(["www", "example", "comx"]),
        MyNameIsURL.HostSuffix(["www", "example", "com", "x"]),
        MyNameIsURL.HostSuffix(["x", "www", "example", "com"]),
        MyNameIsURL.HostSuffix(["", "com"]),
        MyNameIsURL.HostSuffix([" com"]),
        MyNameIsURL.HostSuffix(["com "]),
        MyNameIsURL.HostSuffix(["com", ""]),
      ]
      
      
      static let success = [
        MyNameIsURL.HostSuffix(["com"]),
        MyNameIsURL.HostSuffix(["example", "com"]),
        MyNameIsURL.HostSuffix(["www", "example", "com"]),
      ]
    }
    
    
    enum FromDomains {
      static let failing = [
        try! MyNameIsURL.HostSuffix([Domain(name: "www")]),
        try! MyNameIsURL.HostSuffix([Domain(name: "example")]),
        try! MyNameIsURL.HostSuffix([Domain(name: "com"), Domain(name: "example")]),
        try! MyNameIsURL.HostSuffix([Domain(name: "x"), Domain(name: "com")]),
        try! MyNameIsURL.HostSuffix([Domain(name: "com"), Domain(name: "x")]),
        try! MyNameIsURL.HostSuffix([Domain(name: "m")]),
        try! MyNameIsURL.HostSuffix([Domain(name: "om")]),
        try! MyNameIsURL.HostSuffix([Domain(name: "comx")]),
        try! MyNameIsURL.HostSuffix([Domain(name: "xcom")]),
      ]
      
      static let success = [
        try! MyNameIsURL.HostSuffix([Domain(name: "com")]),
        try! MyNameIsURL.HostSuffix([Domain(name: "example"), Domain(name: "com")]),
        try! MyNameIsURL.HostSuffix([Domain(name: "www"), Domain(name: "example"), Domain(name: "com")]),
      ]
    }
  }
}
