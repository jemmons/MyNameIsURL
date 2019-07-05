import Foundation
import XCTest
import MyNameIsURL



class NotTests: XCTestCase {
  func testNotSuccess() {
    XCTAssertFalse(Not(Factory.Host.FromString.success).matches(url: Factory.url))
    XCTAssertFalse(Not(Factory.Path.FromString.success).matches(url: Factory.url))
    XCTAssertFalse(Not(Factory.Scheme.success).matches(url: Factory.url))
  }
  
  
  func testNotFailure() {
    Factory.Host.FromString.failing.forEach { it in
      XCTAssert(Not(it).matches(url: Factory.url))
    }
    
    Factory.Path.FromString.failing.forEach { it in
      XCTAssert(Not(it).matches(url: Factory.url))
    }
    
    Factory.Scheme.failing.forEach { it in
      XCTAssert(Not(it).matches(url: Factory.url))
    }
  }
}
