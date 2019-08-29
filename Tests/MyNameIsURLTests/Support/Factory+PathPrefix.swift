import Foundation
import MyNameIsURL



extension Factory {
  enum PathPrefix {
    enum Wildcard {
      static let url = URL(string: "http://example.com/foo/bar/baz/thud")!
      
      static let succeeding = [
        // Wildcards replace a single path component:
        MyNameIsURL.PathPrefix(["/", .wildcard, "bar", "baz", "thud"]),
        MyNameIsURL.PathPrefix(["/", "foo", .wildcard, "baz", "thud"]),
        MyNameIsURL.PathPrefix(["/", "foo", "bar", .wildcard, "thud"]),
        MyNameIsURL.PathPrefix(["/", "foo", "bar", "baz", .wildcard]),
        
        // Wildcards are still prefixes:
        MyNameIsURL.PathPrefix(["/", .wildcard, "bar"]),
        MyNameIsURL.PathPrefix(["/", .wildcard, .wildcard, "baz"]),
        MyNameIsURL.PathPrefix(["/", .wildcard, .wildcard, .wildcard, "thud"]),
        
        // Unbounded wildcards are meaningless, but still work:
        MyNameIsURL.PathPrefix(["/", .wildcard]),
        MyNameIsURL.PathPrefix(["/", .wildcard, .wildcard]),
        MyNameIsURL.PathPrefix(["/", .wildcard, .wildcard, .wildcard]),
        MyNameIsURL.PathPrefix(["/", .wildcard, .wildcard, .wildcard, .wildcard]),
      ]
      
      static let failing = [
        // Wildcards with wrong anchors sill fail:
        MyNameIsURL.PathPrefix(["/", "fuzz", .wildcard]),
        MyNameIsURL.PathPrefix(["/", .wildcard, "fuzz"]),
        
        // Wilcards only match a single component
        MyNameIsURL.PathPrefix(["/", .wildcard, "baz"]),
        MyNameIsURL.PathPrefix(["/", "foo", .wildcard, "thud"]),
        MyNameIsURL.PathPrefix(["/", .wildcard, "thud"]),
      ]
    }
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
