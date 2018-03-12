import FluentSQLite
import Vapor
import Foundation

final class AcronymCategoryPivot: SQLiteUUIDPivot {
  var id: UDID?
  var acronymID: Acronim.ID
  var categoryID: categoryID
  
  typealias Left = Acronim
  typealias Right = Category
  
  static let leftIDKey: LeftIDKey = \AcronymCategoryPivot.acronymID
  static let rightIDKey: RightIDKey = \AcronymCategoryPivot.categoryID
  
  
  init(_ acronymID: Acronym.ID, _ categoryID: Category.ID) {
    self.acronymID = acronymID
    self.categoryID = categoryID
  }
}

extension AcronymCategoryPivot: Migration {}
