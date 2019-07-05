import Foundation
import XCTest
import MyNameIsURL



class PathTests: XCTestCase {
  func testFromString() {
    Factory.Path.FromString.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }
    XCTAssert(Factory.Path.FromString.success.matches(url: Factory.url))
  }
  
  
  func testFromComponents() {
    Factory.Path.FromComponents.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }
    XCTAssert(Factory.Path.FromComponents.success.matches(url: Factory.url))
  }
}
