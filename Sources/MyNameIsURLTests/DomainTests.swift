import Foundation
import XCTest
import MyNameIsURL



class DomainTests: XCTestCase  {
  func testValidNames() {
    Factory.DomainName.valid.forEach { name in
      let domain = try! Domain(name: name)
      XCTAssertEqual(name, domain.name)
    }
  }
  
  
  func testInvalidNames() {
    Factory.DomainName.invalid.forEach { name in
      do {
        let unexpectedDomain = try Domain(name: name)
        XCTFail("“\(unexpectedDomain.name)” should not be allowed as a domain, but is.")
      } catch Domain.Format.invalid(let s) {
        XCTAssertEqual(name, s)
      } catch {
        XCTFail()
      }
    }
  }
  
  
  func testEquality() {
    Factory.DomainName.valid.forEach { name in
      XCTAssertEqual(try! Domain(name: name), try! Domain(name: name))
    }
    XCTAssertEqual(try! Domain(name: "example"), try! Domain(name: "Example"))
    XCTAssertEqual(try! Domain(name: "Example"), try! Domain(name: "example"))
    XCTAssertEqual(try! Domain(name: "BIG-little"), try! Domain(name: "big-LITTLE"))
  }
}
