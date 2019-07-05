import Foundation
import XCTest
import MyNameIsURL



class HostTests: XCTestCase {
  func testStringMatching() {
    Factory.Host.FromString.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }
    XCTAssert(Factory.Host.FromString.success.matches(url: Factory.url))
  }
  

  func testCompMatching() {
    Factory.Host.FromComponents.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }
    XCTAssert(Factory.Host.FromComponents.success.matches(url: Factory.url))
  }
  
  
  func testDomainMatching() {
    Factory.Host.FromDomains.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }
    XCTAssert(Factory.Host.FromDomains.success.matches(url: Factory.url))
  }
}
