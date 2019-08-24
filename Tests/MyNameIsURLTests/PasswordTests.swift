import XCTest
import MyNameIsURL



class PasswordTests: XCTestCase {
  func testSuccess() {
    XCTAssert(Factory.Password.success.matches(url: Factory.url))
    XCTAssertFalse(Factory.Password.success.matches(url: Factory.nilURL))
  }
  
  
  func testNil() {
    XCTAssertFalse(Password.missing.matches(url: Factory.url))
    XCTAssert(Password.missing.matches(url: Factory.nilURL))
  }
  
  
  func testBlankPassword() {
    let subject = URL(string: "http://foo:@example.com")!
    XCTAssert(Password("").matches(url: subject))
  }
  
  
  func testUserWithMissingPassword() {
    let subject = URL(string: "http://foo@example.com")!
    XCTAssert(Password.missing.matches(url: subject))
  }
}
