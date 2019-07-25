import Foundation



/**
 Type that matches a `URL` based on the suffix of the `URL`’s `host` propery.
 
 Usage:
 ```
 let url = URL(string: "https://example.com")!
 HostSuffix(["example", "com"]).matches(url) //> true
 HostSuffix(["com"]).matches(url)            //> true
 ```
 
 - SeeAlso: `Host` 
 */
public struct HostSuffix: URLMatchable {
  private let domains: [String]
  /**
   Wraps the given domains to create a new `HostSuffix` value. It matches against suffixes of `URL.host` split into domain names.
   
   
   
   
   - SeeAlso: `Host`
   
   - Parameter domains: A collection of domains together representing a suffix of the host to match.
   
     `URL.host` will be split into its composite domains before being compared with this collection.
   */
  public init(_ domains: [String]) {
    self.domains = domains
  }
  
  
  /**
   Wraps the given components to create a new `HostSuffix` value. It matches against suffixes of a `URL`’s `host` property.
   
   Given `URL.host` is a string, and the `Host` type wraps a string, why does `HostSuffix` wrap an collection of domains? Because matching a host suffix by string is a common security issue.
   
   Consider the URL “www.example.com”. We may wish to match only the “example.com” part so we naïvely create a value like `HostSuffix("example.com")`. This looks straight-forward, but also matches “hijackexample.com”. Even if we catch this and use the (easy to overlook) `HostSuffix(".example.com")` we now have a situation where “example.com” doesn’t match because it has no leading `"."` leading to non-obvious solutions (like `Or(Host("example.com"), HostSuffix(".example.com"))`) for what should be an obvious thing.
   
   Requiring an array of domains not only forces us to think through these issues but also has the virtuous property of making the naïve solution the correct one — `HostSuffix(["example", "com"])` matches both “www.example.com” and “example.com” but *does not* match “hijackexample.com”.
   
   - SeeAlso: `Host`
   
   - Parameter domains: A collection of domains together representing a suffix of the host to match.
   
     These domains will be joined with a `"."` when compared.
   */
  public init(_ domains: [Domain]) {
    self.domains = domains.map { $0.name }
  }
  

  /**
   Predicate that determines whether a `HostSuffix` matches a given `URL`.
   
   - Parameter url: The `URL` to be matched.
   
   - Returns: `true` if the wrapped domains (joined by `"."`) equal a suffix of `url.host`. Otherwise, `false`.
   */
  public func matches(url: URL) -> Bool {
    let hostComponents = url.host?.hostComponents() ?? []
    let hostSuffix = hostComponents.suffix(domains.count)
    return domains == Array(hostSuffix)
  }
}
