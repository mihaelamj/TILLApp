final class Category: Codable {
  var id : Int?
  var name: String
  
  init(name: String) {
    self.name = name
  }
}

#if Xcode
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
#endif
