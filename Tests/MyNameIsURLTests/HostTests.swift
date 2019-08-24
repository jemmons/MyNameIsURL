import Foundation
import XCTest
import MyNameIsURL



class HostTests: XCTestCase {
  func testMatching() {
    XCTAssert(Factory.Host.success.matches(url: Factory.url))
  }
  
  
  func testNil() {
    XCTAssert(Host.missing.matches(url: Factory.nilURL))
    XCTAssertFalse(Factory.Host.success.matches(url: Factory.nilURL))
  }

  
  func testNonMatching() {
    let ran = expectation(description: "Loop ran.")
    ran.assertForOverFulfill = false
    Factory.Host.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
      XCTAssertFalse(it.matches(url: Factory.nilURL))
      ran.fulfill()
    }
    wait(for: [ran], timeout: 0)
  }
}
