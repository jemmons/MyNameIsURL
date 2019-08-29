import Foundation
import MyNameIsURL


enum Factory {
  static let url = URL(string: "http://please:don't@www.example.com:80/foo/bar")!
  static let nilURL = URL(string: "//")!
}
