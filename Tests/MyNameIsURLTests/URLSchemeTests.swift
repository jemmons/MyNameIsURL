import Foundation
import XCTest
import MyNameIsURL



class URLSchemeTests: XCTestCase {
  func testReplacingScheme() {
    let subject = URL(string: "tel://example.com")!.replacing(scheme: Scheme.telprompt)
    XCTAssertEqual("telprompt://example.com", subject.absoluteString)
  }
  
  
  func testResplacingNilScheme() {
    try! XCTAssertEqual("foo", Factory.nilURL.replacing(scheme: Scheme("foo")).scheme)
  }
}
