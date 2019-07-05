import Foundation
import XCTest
import MyNameIsURL



class HostSuffixTests: XCTestCase {
  func testFromString() {
    Factory.HostSuffix.FromString.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }
    
    
    Factory.HostSuffix.FromString.success.forEach { it in
      XCTAssert(it.matches(url: Factory.url))
    }
  }
  
  
  func testFromComponents() {
    Factory.HostSuffix.FromComponents.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }
    
    Factory.HostSuffix.FromComponents.success.forEach { it in
      XCTAssert(it.matches(url: Factory.url))
    }
  }
  
  
  func testFromDomains() {
    Factory.HostSuffix.FromDomains.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
    }
    
    Factory.HostSuffix.FromDomains.success.forEach { it in
      XCTAssert(it.matches(url: Factory.url))
    }
  }
}
