import FluentSQLite
import Vapor

extension Category: SQLiteModel {}
extension Category: Content{}
extension Category: Migration{}

extension Category {
  var acronyms: Siblings<Category, Acronym, AcronymCategoryPivot> {
    return siblings()
  }
}
