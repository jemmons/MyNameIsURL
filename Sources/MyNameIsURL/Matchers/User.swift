import Foundation



public struct User: URLMatchable {
  private struct Missing: URLMatchable {
    func matches(url: URL) -> Bool {
      return url.user == nil
    }
  }
  
  
  /**
   A value that matches a `URL` with a `user` property of `nil`.
   
   RFC 1738 (and this package) makes a distinction between *empty* (`""`) users and *no* (`nil`) users:
   
   > Note that an empty user name or password is different than no user name or password.
   
   As such, this value only matches against no (`nil`) users. In practice this is a pretty meaningless distinction because please-god-don’t-put-auth-info-in-your-URLs. But if there is occation to match an *empty* user, one can use `User("")` to achieve that purpose.
   
   Usage:
   ```
   let user = URL(string: "http://user:pass@example.com")!
   let emptyUser = URL(string: "http://@example.com")!
   let noUser = URL(string: "http://example.com")!
   User.missing.matches(url: user)      //> false
   User.missing.matches(url: emptyUser) //> false
   User.missing.matches(url: noUser)    //> true
   ```
   */
  public static let missing: URLMatchable = Missing()
  private let user: String
  
  
  public init(_ user: String) {
    self.user = user
  }
  
  
  public func matches(url: URL) -> Bool {
    return url.user == user
  }
}
