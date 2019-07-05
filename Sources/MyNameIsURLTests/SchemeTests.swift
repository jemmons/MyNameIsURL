import Foundation
import XCTest
import MyNameIsURL



class SchemeTest: XCTestCase {
  func testScheme() {
    Factory.Scheme.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }
    XCTAssert(Factory.Scheme.success.matches(url: Factory.url))
  }
}

