import Foundation
import XCTest
import MyNameIsURL



class PatternOperatorTests: XCTestCase {
  func testHostMatch() {
    switch Factory.url {
    case Not(Factory.Host.FromString.success):
      XCTFail()
    case Factory.Host.FromString.success:
      XCTAssert(true)
    default:
      XCTFail()
    }
  }
  
  
  func testHostSuffixMatch() {
    Factory.HostSuffix.FromString.success.forEach { it in
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
    case Not(Factory.Path.FromString.success):
      XCTFail()
    case Factory.Path.FromString.success:
      XCTAssert(true)
    default:
      XCTFail()
    }
  }
  
  
  func testPathPrefixMatch() {
    Factory.PathPrefix.FromString.success.forEach { it in
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
      Factory.Host.FromString.success,
      Factory.Path.FromString.success)
    
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
      Factory.Host.FromString.success,
      Factory.Path.FromString.success)
    
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
