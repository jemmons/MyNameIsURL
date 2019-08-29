import Foundation
import MyNameIsURL



extension Factory {
  enum Port {
    static let success = MyNameIsURL.Port(80)
    static let failures = [
      MyNameIsURL.Port(443),
      MyNameIsURL.Port(800),
      MyNameIsURL.Port(-80),
      MyNameIsURL.Port.missing,
    ]
  }
}
