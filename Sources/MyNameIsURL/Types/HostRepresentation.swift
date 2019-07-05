import Foundation



internal enum HostRepresentation {
  case string(String)
  case components([String])
  case domains([Domain])
}
