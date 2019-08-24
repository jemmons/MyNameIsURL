import XCTest
import MyNameIsURL



class PortTests: XCTestCase {
  func testSuccess() {
    XCTAssert(Factory.Port.success.matches(url: Factory.url))
    Factory.Port.failures.forEach {
      XCTAssertFalse($0.matches(url: Factory.url))
    }
  }

  
  func testNil() {
    XCTAssert(Port.missing.matches(url: Factory.nilURL))
  }
  
  
  func testURLDoesNotDefault() {
    let defaultHTTPPort = URL(string: "http://example.com")!
    XCTAssertFalse(Factory.Port.success.matches(url: defaultHTTPPort))
    XCTAssert(Port.missing.matches(url: defaultHTTPPort))
  }
  
  
  func testLeadingZeroes() {
    let leadingZeroes = URL(string: "http://example.com:0080")!
    XCTAssert(Factory.Port.success.matches(url: leadingZeroes))
  }
}
