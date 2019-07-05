import Foundation
import MyNameIsURL



extension Factory {
  enum PathPrefix {
    enum FromString {
      static let failing = [
        MyNameIsURL.PathPrefix("foo"),
        MyNameIsURL.PathPrefix("bar"),
        MyNameIsURL.PathPrefix("foo/bar"),
        MyNameIsURL.PathPrefix("/foo/bar/"),
        MyNameIsURL.PathPrefix("x/"),
        MyNameIsURL.PathPrefix(" /"),
        MyNameIsURL.PathPrefix("/ "),
        MyNameIsURL.PathPrefix("/foo/barx"),
        MyNameIsURL.PathPrefix("x/foo/bar"),
      ]

      
      static let success = [
        MyNameIsURL.PathPrefix(""),
        MyNameIsURL.PathPrefix("/"),
        MyNameIsURL.PathPrefix("/f"),
        MyNameIsURL.PathPrefix("/fo"),
        MyNameIsURL.PathPrefix("/foo"),
        MyNameIsURL.PathPrefix("/foo/"),
        MyNameIsURL.PathPrefix("/foo/b"),
        MyNameIsURL.PathPrefix("/foo/ba"),
        MyNameIsURL.PathPrefix("/foo/bar"),
      ]
    }
    
    
    enum FromComponents {
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
}
