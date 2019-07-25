import Foundation
import MyNameIsURL



extension Factory {
  enum PathPrefix {
    static let failing = [
      MyNameIsURL.PathPrefix(["foo"]),
      MyNameIsURL.PathPrefix(["bar"]),
      MyNameIsURL.PathPrefix(["foo", "bar"]),
      MyNameIsURL.PathPrefix(["/", "foo", "/"]),
      MyNameIsURL.PathPrefix(["/", "foo", "/", "bar"]),
      MyNameIsURL.PathPrefix(["x"]),
      MyNameIsURL.PathPrefix([""]),
      MyNameIsURL.PathPrefix([" /"]),
      MyNameIsURL.PathPrefix(["/ "]),
      MyNameIsURL.PathPrefix(["/", "f"]),
      MyNameIsURL.PathPrefix(["/", "foo", "barx"]),
      MyNameIsURL.PathPrefix(["/", "foo", "bar", "x"]),
      MyNameIsURL.PathPrefix(["x", "/", "foo", "bar"]),
    ]
    
    
    static let success = [
      MyNameIsURL.PathPrefix(["/"]),
      MyNameIsURL.PathPrefix(["/", "foo"]),
      MyNameIsURL.PathPrefix(["/", "foo", "bar"]),
    ]
  }
}
