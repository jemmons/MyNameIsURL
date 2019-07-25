import Foundation
import XCTest
import MyNameIsURL



class PatternOperatorTests: XCTestCase {
  func testHostMatch() {
    switch Factory.url {
    case Not(Factory.Host.success):
      XCTFail()
    case Factory.Host.success:
      XCTAssert(true)
    default:
      XCTFail()
    }
  }
  
  
  func testHostSuffixMatch() {
    Factory.HostSuffix.FromComponents.success.forEach { it in
      switch Factory.url {
      case Not(it):
        XCTFail()
      case it:
        XCTAssert(true)
      default:
        XCTFail()
      }
    }
  }
  
  
  func testPathMatch() {
    switch Factory.url {
    case Not(Factory.Path.success):
      XCTFail()
    case Factory.Path.success:
      XCTAssert(true)
    default:
      XCTFail()
    }
  }
  
  
  func testPathPrefixMatch() {
    Factory.PathPrefix.success.forEach { it in
      switch Factory.url {
      case Not(it):
        XCTFail()
      case it:
        XCTAssert(true)
      default:
        XCTFail()
      }
    }
  }
  
  
  func testSchemeMatch() {
    switch Factory.url {
    case Not(Factory.Scheme.success):
      XCTFail()
    case Factory.Scheme.success:
      XCTAssert(true)
    default:
      XCTFail()
    }
  }
  
  
  func testAndMatch() {
    let subject = And(
      Factory.Scheme.success,
      Factory.Host.success,
      Factory.Path.success)
    
    switch Factory.url {
    case Not(subject):
      XCTFail()
    case subject:
      XCTAssert(true)
    default:
      XCTFail()
    }
  }
  
  
  func testOrMatch() {
    let subject = Or(
      Factory.Scheme.success,
      Factory.Host.success,
      Factory.Path.success)
    
    switch Factory.url {
    case Not(subject):
      XCTFail()
    case subject:
      XCTAssert(true)
    default:
      XCTFail()
    }
  }
}
