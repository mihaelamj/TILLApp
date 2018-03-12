import FluentSQLite
import Vapor

final class Acronym: Codable {
  var id : Int?
  var short: String
  var long: String
  
  init(short: String, long: String) {
    self.short = short
    self.long = long
  }
  
}

//extension Acronym: Model {
//  typealias Database = SQLiteDatabase
//  typealias ID = Int
//  static let idKey: IDKey = \Acronym.id
//}
//or just conform to SQLiteModel
extension Acronym: SQLiteModel {}

extension Acronym: Content{}

extension Acronym: Migration{}

