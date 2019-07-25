import Foundation
import XCTest
import MyNameIsURL



class NotTests: XCTestCase {
  func testNotSuccess() {
    XCTAssertFalse(Not(Factory.Host.success).matches(url: Factory.url))
    XCTAssertFalse(Not(Factory.Path.success).matches(url: Factory.url))
    XCTAssertFalse(Not(Factory.Scheme.success).matches(url: Factory.url))
    XCTAssert(Not(Factory.Host.success).matches(url: Factory.nilURL))
    XCTAssert(Not(Factory.Path.success).matches(url: Factory.nilURL))
    XCTAssert(Not(Factory.Scheme.success).matches(url: Factory.nilURL))
  }
  
  
  func testNotFailure() {
    Factory.Host.failing.forEach { it in
      XCTAssert(Not(it).matches(url: Factory.url))
      XCTAssert(Not(it).matches(url: Factory.nilURL))
    }
    
    Factory.HostSuffix.FromComponents.failing.forEach { it in
      XCTAssert(Not(it).matches(url: Factory.url))
      XCTAssert(Not(it).matches(url: Factory.nilURL))
    }
    
    Factory.Path.failing.forEach { it in
      XCTAssert(Not(it).matches(url: Factory.url))
    }
    
    Factory.PathPrefix.failing.forEach { it in
      XCTAssert(Not(it).matches(url: Factory.url))
      XCTAssert(Not(it).matches(url: Factory.nilURL))
    }
    
    Factory.Scheme.failing.forEach { it in
      XCTAssert(Not(it).matches(url: Factory.url))
      XCTAssert(Not(it).matches(url: Factory.nilURL))
    }
  }
}
