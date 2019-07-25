import Foundation
import XCTest
import MyNameIsURL



class HostSuffixTests: XCTestCase {
  func testFromComponents() {
    Factory.HostSuffix.FromComponents.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
      XCTAssertFalse(it.matches(url: Factory.nilURL))
    }
    
    Factory.HostSuffix.FromComponents.success.forEach { it in
      XCTAssert(it.matches(url: Factory.url))
    }
  }
  
  
  func testFromDomains() {
    Factory.HostSuffix.FromDomains.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
      XCTAssertFalse(it.matches(url: Factory.nilURL))
    }
    
    Factory.HostSuffix.FromDomains.success.forEach { it in
      XCTAssert(it.matches(url: Factory.url))
    }
  }
}
