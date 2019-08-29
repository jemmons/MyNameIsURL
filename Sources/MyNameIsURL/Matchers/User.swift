import Foundation



/**
 Type that matches a `URL` based on comparison with the `URL`’s `user` propery.
 
 Usage:
 ```
 let url = URL(string: "https://user:pass@example.com")!
 User("user").matches(url) //> true
 ```
 
 - Note: RFC 1738 makes a distinction between *empty* (`""`) users and *no* (`nil`) users. In the uncommon case you need to match a URL with an *empty* user name (*i.e.* “http://@example.com”), create a `User` with an empty string: `User("")`. The much more common *no* user can be matched with `User.missing`.
 
 - SeeAlso: `Password`, `User.missing`
 */
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
  
  
  /**
   Wraps the given string to create a new `User` value. It matches `URL`s based on their `user` property.
   
   - SeeAlso: `Password`
   
   - Parameter user: The user name to match. It will be compared for equality against `URL`’s `user` property.
   */
  public init(_ user: String) {
    self.user = user
  }
  
  
  /**
   Predicate that determines whether a `User` matches a given `URL`.
   
   - Parameter url: The `URL` to be matched.
   
   - Returns: `true` if the wrapped user name is equivalent to `url.user`. Otherwise, `false`.
   */
  public func matches(url: URL) -> Bool {
    return url.user == user
  }
}
