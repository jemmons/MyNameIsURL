import Foundation
import XCTest
import MyNameIsURL



class PathPrefixTests: XCTestCase {
  func testFromString() {
    Factory.PathPrefix.FromString.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }
    
    Factory.PathPrefix.FromString.success.forEach { it in
      XCTAssert(it.matches(url: Factory.url))
    }
  }
  
  
  func testFromComponents() {
    Factory.PathPrefix.FromComponents.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }

    Factory.PathPrefix.FromComponents.success.forEach { it in
      XCTAssert(it.matches(url: Factory.url))
    }
  }
}
