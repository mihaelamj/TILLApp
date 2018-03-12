import Vapor

struct CategoriesController: RouteCollection {
  
  func boot(router: Router) throws {
    let categoriesRoute = router.grouped("api", "categories")
    categoriesRoute.get(use: getAllHandler)
    categoriesRoute.post(use: createHandler)
    categoriesRoute.get(Category.parameter, use: getHandler)
  }
  
  //GET /api/categories
  func getAllHandler(_ req: Request) throws -> Future<[Category]> {
    return Category.query(on: req).all()
  }
  
  //POST /api/categories/ (JSON in the body)
  func createHandler(_ req: Request) throws -> Future<Category> {
    return try req.content.decode(Category.self).flatMap(to: Category.self) { category in
      return category.save(on: req)
    }
  }
  
  //GET /api/categories/42
  func getHandler(_ req: Request) throws -> Future<Category> {
    return try req.parameter(Category.self)
  }
  
}

//conform to Parameter protocol
extension Category: Parameter{}
