import Foundation
import XCTest
import MyNameIsURL



class SchemeTests: XCTestCase {
  func testStaticHTTP() {
    let subject = try! Scheme("http")
    XCTAssertEqual(subject, Scheme.http)
    XCTAssertEqual(Factory.Scheme.staticSchemes.count - 1, Factory.Scheme.staticSchemes.filter { $0 != subject }.count)
  }
  
  
  func testStaticHTTPS() {
    let subject = try! Scheme("https")
    XCTAssertEqual(subject, Scheme.https)
    XCTAssertEqual(Factory.Scheme.staticSchemes.count - 1, Factory.Scheme.staticSchemes.filter { $0 != subject }.count)
  }
  
  
  func testStaticTel() {
    let subject = try! Scheme("tel")
    XCTAssertEqual(subject, Scheme.tel)
    XCTAssertEqual(Factory.Scheme.staticSchemes.count - 1, Factory.Scheme.staticSchemes.filter { $0 != subject }.count)
  }
  
  
  func testStaticTelPrompt() {
    let subject = try! Scheme("telprompt")
    XCTAssertEqual(subject, Scheme.telprompt)
    XCTAssertEqual(Factory.Scheme.staticSchemes.count - 1, Factory.Scheme.staticSchemes.filter { $0 != subject }.count)
  }


  func testStaticSMS() {
    let subject = try! Scheme("sms")
    XCTAssertEqual(subject, Scheme.sms)
    XCTAssertEqual(Factory.Scheme.staticSchemes.count - 1, Factory.Scheme.staticSchemes.filter { $0 != subject }.count)
  }
  
  
  func testStaticMailTo() {
    let subject = try! Scheme("mailto")
    XCTAssertEqual(subject, Scheme.mailto)
    XCTAssertEqual(Factory.Scheme.staticSchemes.count - 1, Factory.Scheme.staticSchemes.filter { $0 != subject }.count)
  }
  
  
  func testStaticWebCal() {
    let subject = try! Scheme("webcal")
    XCTAssertEqual(subject, Scheme.webcal)
    XCTAssertEqual(Factory.Scheme.staticSchemes.count - 1, Factory.Scheme.staticSchemes.filter { $0 != subject }.count)
  }

  
  func testStaticFile() {
    let subject = try! Scheme("file")
    XCTAssertEqual(subject, Scheme.file)
    XCTAssertEqual(Factory.Scheme.staticSchemes.count - 1, Factory.Scheme.staticSchemes.filter { $0 != subject }.count)
  }


  func testStaticFTP() {
    let subject = try! Scheme("ftp")
    XCTAssertEqual(subject, Scheme.ftp)
    XCTAssertEqual(Factory.Scheme.staticSchemes.count - 1, Factory.Scheme.staticSchemes.filter { $0 != subject }.count)
  }

  func testEmptyScheme() {
    let expectedFailure = expectation(description: "Waiting for format error.")
    do {
      _ = try Scheme("")
    } catch Scheme.Size.tooSmall {
      expectedFailure.fulfill()
    } catch {}
    
    wait(for: [expectedFailure], timeout: 0)
  }
  

  func testInvalidCharacter() {
    let expectedFailure = expectation(description: "Waiting for format error.")
    do {
      _ = try Scheme("h*tp")
    } catch Scheme.Format.invalidCharacter("h*tp", false) {
      expectedFailure.fulfill()
    } catch {}
    wait(for: [expectedFailure], timeout: 0)
  }
  
  
  func testInvalidStartingCharacter() {
    let validButInFirstFailure = expectation(description: "Fails with valid character that's invalid as first letter.")
    let alwaysInvalidFailure = expectation(description: "Fails with first character that's invalid everywhere")

    do {
      _ = try Scheme("1http")
    } catch Scheme.Format.invalidCharacter("1http", true) {
      validButInFirstFailure.fulfill()
    } catch {}
    
    do {
      _ = try Scheme("*http")
    } catch Scheme.Format.invalidCharacter("*http", true) {
      alwaysInvalidFailure.fulfill()
    } catch {}

    wait(for: [validButInFirstFailure, alwaysInvalidFailure], timeout: 0)
  }
  
  
  func testCaseEquality() {
    XCTAssertEqual(try! Scheme("HTTP"), Scheme.http)
    XCTAssertEqual(try! Scheme("FoObAr"), try! Scheme("foobar"))
  }
  
  
  func testSchemeMatching() {
    Factory.Scheme.failing.forEach { it in
      XCTAssertFalse(it.matches(url: Factory.url))
      XCTAssertFalse(it.matches(url: Factory.nilURL))
    }
    XCTAssert(Factory.Scheme.success.matches(url: Factory.url))
    XCTAssertFalse(Factory.Scheme.success.matches(url: Factory.nilURL))
  }
}

