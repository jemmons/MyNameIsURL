import Foundation
import XCTest
import MyNameIsURL



class AndTests: XCTestCase {
  let subject = And(
    Factory.Scheme.success,
    Factory.Host.FromString.success,
    Factory.Path.FromString.success)

  func testSuccess() {
    XCTAssert(subject.matches(url: Factory.url))
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
