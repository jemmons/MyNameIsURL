import Foundation
import XCTest
import MyNameIsURL



class OrTests: XCTestCase {
  let subject = Or(
    Factory.Scheme.success,
    Factory.Host.success,
    Factory.Path.success)
  
  func testSuccess() {
    XCTAssert(subject.matches(url: Factory.url))
    XCTAssertFalse(subject.matches(url: Factory.nilURL))

    let badScheme = URL(string: "https://www.example.com/foo/bar")!
    XCTAssert(subject.matches(url: badScheme))
    
    let badHost = URL(string: "http://www2.example.com/foo/bar")!
    XCTAssert(subject.matches(url: badHost))
    
    let badPath = URL(string: "http://www.example.com/foo/baz")!
    XCTAssert(subject.matches(url: badPath))
    
    let badSchemeAndHost = URL(string: "https://www2.example.com/foo/bar")!
    XCTAssert(subject.matches(url: badSchemeAndHost))

    let badHostAndPath = URL(string: "http://www2.example.com/foo/baz")!
    XCTAssert(subject.matches(url: badHostAndPath))

    let badSchemeAndPath = URL(string: "https://www.example.com/foo/baz")!
    XCTAssert(subject.matches(url: badSchemeAndPath))
  }
  
  
  func testFailure() {
    let badSchemeAndHostAndPath = URL(string: "https://www2.example.com/foo/baz")!
    XCTAssertFalse(subject.matches(url: badSchemeAndHostAndPath))
  }
}
