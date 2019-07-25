import Foundation
import MyNameIsURL



extension Factory {
  enum Path {
    static let failing = [
      MyNameIsURL.Path(""),
      MyNameIsURL.Path("/foo/bar/"),
      MyNameIsURL.Path("foo/bar"),
      MyNameIsURL.Path("/foo"),
      MyNameIsURL.Path("/foo/"),
      MyNameIsURL.Path("bar"),
      MyNameIsURL.Path("/bar"),
      MyNameIsURL.Path("x/foo/bar"),
      MyNameIsURL.Path("/foo/barx"),
      MyNameIsURL.Path("/foo/bar "),
      MyNameIsURL.Path(" /foo/bar"),
      MyNameIsURL.Path("/foo /bar"),
    ]
    static let success = MyNameIsURL.Path("/foo/bar")
  }
}
