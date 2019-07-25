import Foundation
import MyNameIsURL


enum Factory {
  static let url = URL(string: "http://www.example.com/foo/bar")!
  static let nilURL = URL(string: "//")!
}
