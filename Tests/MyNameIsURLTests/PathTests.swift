import Foundation
import XCTest
import MyNameIsURL



class PathTests: XCTestCase {
  func testMatches() {
    XCTAssert(Factory.Path.success.matches(url: Factory.url))
  }
  
  
  func testNoNilMatches() {
    XCTAssertFalse(Factory.Path.success.matches(url: Factory.nilURL))
  }
  
  
  func testNonMatches() {
    let ran = expectation(description: "Loop ran.")
    ran.assertForOverFulfill = false
    Factory.Path.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
      ran.fulfill()
    }
    wait(for: [ran], timeout: 0)
  }


  func testTrailingSlash() {
    let subject = URL(string: "https://example.com/foo/bar/")!
    XCTAssert(Path("/foo/bar").matches(url: subject))
    XCTAssertFalse(Path("/foo/bar/").matches(url: subject))
  }
}
