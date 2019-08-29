import Foundation
import XCTest
import MyNameIsURL



class PathPrefixTests: XCTestCase {
  func testMatches() {
    let ran = expectation(description: "Loop ran.")
    ran.assertForOverFulfill = false
    Factory.PathPrefix.success.forEach { it in
      XCTAssert(it.matches(url: Factory.url))
      ran.fulfill()
    }
    wait(for: [ran], timeout: 0)
  }
  
  
  func testNonMatches() {
    let ran = expectation(description: "Loop ran.")
    ran.assertForOverFulfill = false
    Factory.PathPrefix.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
      XCTAssertFalse(it.matches(url: Factory.nilURL))
      ran.fulfill()
    }
    wait(for: [ran], timeout: 0)
  }
  
  
  func testWildcardSuccess() {
    let ran = expectation(description: "Loop ran.")
    ran.assertForOverFulfill = false
    Factory.PathPrefix.Wildcard.succeeding.forEach {
      XCTAssert($0.matches(url: Factory.PathPrefix.Wildcard.url))
      ran.fulfill()
    }
    wait(for: [ran], timeout: 0)
  }
  
  
  func testWildcardFailure() {
    let ran = expectation(description: "Loop ran.")
    ran.assertForOverFulfill = false
    Factory.PathPrefix.Wildcard.failing.forEach {
      XCTAssertFalse($0.matches(url: Factory.PathPrefix.Wildcard.url))
      ran.fulfill()
    }
    wait(for: [ran], timeout: 0)
  }
}
