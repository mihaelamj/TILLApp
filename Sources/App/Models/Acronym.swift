import FluentSQLite
import Vapor

//extension Acronym: Model {
//  typealias Database = SQLiteDatabase
//  typealias ID = Int
//  static let idKey: IDKey = \Acronym.id
//}
//or just conform to SQLiteModel
extension Acronym: SQLiteModel {}

extension Acronym: Content{}
extension Acronym: Migration{}

//extension to get our parent, creator is a computer property
extension Acronym {
  var creator: Parent<Acronym, User> {
    return parent(\.creatorID) //key-path
  }
  
  var categories: Siblings<Acronym, Category, AcronymCategoryPivot> {
    return siblings()
  }
}

