import Foundation

final class User: Codable {
  var id: UUID?
  var name: String
  var username: String
  
  init(name: String, username: String) {
    self.name = name
    self.username = username
  }
}

import FluentSQLite
import Vapor

extension User: SQLiteUUIDModel {}
extension User: Content{}
extension User: Migration{}

//extension to get all the acronyms of a user
extension User {
  var acronyms: Children<User, Acronym> {
    return children(\.creatorID)
  }
}

