import Foundation
import XCTest
import MyNameIsURL



class URLSchemeTests: XCTestCase {
  func testReplacingScheme() {
    let subject = URL(string: "tel://example.com")!.replacingScheme(Scheme.telprompt)
    XCTAssertEqual("telprompt://example.com", subject.absoluteString)
  }
}
