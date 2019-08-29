import Foundation



public struct Password: URLMatchable {
  private struct Missing: URLMatchable {
    func matches(url: URL) -> Bool {
      return url.password == nil
    }
  }
    
  
  /**
   A value that matches a `URL` with a `password` property of `nil`.
   
   RFC 1738 (and this package) makes a distinction between *empty* (`""`) passwords and *no* (`nil`) passwords:
   
   > Note that an empty user name or password is different than no user name or password.
   
   As such, this value only matches against no (`nil`) passwords. In practice this is a pretty meaningless distinction because please-god-don’t-put-auth-info-in-your-URLs. But if there is occation to match an *empty* password, one can use `Password("")` to achieve that purpose.
   
   Usage:
   ```
   let password = URL(string: "http://user:pass@example.com")!
   let emptyPassword = URL(string: "http://user:@example.com")!
   let noPassword = URL(string: "http://example.com")!
   Password.missing.matches(url: password)      //> false
   Password.missing.matches(url: emptyPassword) //> false
   Password.missing.matches(url: noPassword)    //> true
   ```
   */
  public static let missing: URLMatchable = Missing()
  
  
  private let password: String
  
  
  public init(_ password: String ) {
    self.password = password
  }
  
  
  public func matches(url: URL) -> Bool {
    return url.password == password
  }
}
