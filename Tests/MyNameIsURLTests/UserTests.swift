import XCTest
import MyNameIsURL



class UserTests: XCTestCase {
  func testSuccess() {
    XCTAssert(Factory.User.success.matches(url: Factory.url))
    XCTAssertFalse(Factory.User.success.matches(url: Factory.nilURL))
  }
  
  
  func testNil() {
    XCTAssertFalse(User.missing.matches(url: Factory.url))
    XCTAssert(User.missing.matches(url: Factory.nilURL))
  }
  
  
  func testFailure() {
    Factory.User.failures.forEach {
      XCTAssertFalse($0.matches(url: Factory.url))
      XCTAssertFalse($0.matches(url: Factory.nilURL))
    }
  }
  
  
  func testBlankUserURLs() {
    [
      URL(string: "http://@example.com")!,
      URL(string: "http://:@example.com")!,
    ].forEach {
      XCTAssertFalse(User.missing.matches(url: $0))
      XCTAssert(User("").matches(url: $0))
    }
  }
  
  
  func testUserWithMissingOrPasswordStillWorks() {
    [
      URL(string: "http://someone:@example.com")!,
      URL(string: "http://someone@example.com")!,
    ].forEach {
      XCTAssertFalse(User.missing.matches(url: $0))
      XCTAssert(User("someone").matches(url: $0))
    }
  }
}

