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

