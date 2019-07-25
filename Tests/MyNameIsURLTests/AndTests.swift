import Foundation
import XCTest
import MyNameIsURL



class AndTests: XCTestCase {
  let subject = And(
    Factory.Scheme.success,
    Factory.Host.success,
    Factory.Path.success)

  func testSuccess() {
    XCTAssert(subject.matches(url: Factory.url))
    XCTAssertFalse(subject.matches(url: Factory.nilURL))
  }
  
  
  func testFailure() {
    let badScheme = URL(string: "https://www.example.com/foo/bar")!
    XCTAssertFalse(subject.matches(url: badScheme))

    let badHost = URL(string: "http://www2.example.com/foo/bar")!
    XCTAssertFalse(subject.matches(url: badHost))
    
    let badPath = URL(string: "http://www.example.com/foo/baz")!
    XCTAssertFalse(subject.matches(url: badPath))
  }
}
