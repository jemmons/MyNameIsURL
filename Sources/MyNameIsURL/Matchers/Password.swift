import Foundation



/**
 Type that matches a `URL` based on comparison with the `URL`’s `password` propery.
 
 Usage:
 ```
 let url = URL(string: "https://user:pass@example.com")!
 Password("pass").matches(url) //> true
 ```
 
 - Note: RFC 1738 makes a distinction between *empty* (`""`) passwords and *no* (`nil`) passwords. In the uncommon case you need to match a URL with an *empty* password (*i.e.* “http://foo:@example.com”), create a `Password` with an empty string: `Password("")`. The much more common *no* password can be matched with `Password.missing`.
 
 - SeeAlso: `User`, `Password.missing`
 */
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
  
  
  /**
   Wraps the given string to create a new `Password` value. It matches `URL`s based on their `password` property.
   
   - SeeAlso: `User`
   
   - Parameter password: The password to match. It will be compared for equality against `URL`’s `password` property.
   */
  public init(_ password: String ) {
    self.password = password
  }
  
  
  /**
   Predicate that determines whether a `Password` matches a given `URL`.
   
   - Parameter url: The `URL` to be matched.
   
   - Returns: `true` if the wrapped password is equivalent to `url.password`. Otherwise, `false`.
   */
  public func matches(url: URL) -> Bool {
    return url.password == password
  }
}
