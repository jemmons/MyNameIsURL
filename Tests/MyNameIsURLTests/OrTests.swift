import Foundation
import XCTest
import MyNameIsURL



class OrTests: XCTestCase {
  let subject = Or(
    Factory.Scheme.success,
    Factory.User.success,
    Factory.Password.success,
    Factory.Host.success,
    Factory.Path.success,
    Factory.Port.success)
  
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
    
    let onlyGoodPort = URL(string: "foo://nothing.test:80/foo/baz")!
    XCTAssert(subject.matches(url: onlyGoodPort))
    
    let onlyGoodUser = URL(string: "foo://please@nothing.test:64/nothing")!
    XCTAssert(subject.matches(url: onlyGoodUser))

    let onlyGoodPassword = URL(string: "foo://foo:don't@nothing.test:64/nothing")!
    XCTAssert(subject.matches(url: onlyGoodPassword))
  }
  
  
  func testFailure() {
    let badSchemeAndHostAndPath = URL(string: "https://foo:bar@www2.example.com:48/foo/baz")!
    XCTAssertFalse(subject.matches(url: badSchemeAndHostAndPath))
  }
}
