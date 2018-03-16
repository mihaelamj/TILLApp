import Vapor
import Fluent

struct AcronymsController: RouteCollection {
  
  func boot(router: Router) throws {
    let acronymsRoute = router.grouped("api", "acronyms")
    
//    let a = Acronym.parameter
    
    acronymsRoute.get(use: getAllHandler)
    acronymsRoute.post(use: createHandler)
    acronymsRoute.get(Acronym.parameter, use: getHandler)
    acronymsRoute.delete(Acronym.parameter, use: deleteHandler)
    acronymsRoute.put(Acronym.parameter, use: updateHandler)
    acronymsRoute.get(Acronym.parameter, "creator", use: getCreatorHandle)
    acronymsRoute.get(Acronym.parameter, "categories", use: getCategoriesHandler)
    acronymsRoute.post(Acronym.parameter, "categories", Category.parameter, use: addCategoriesHandler)
    acronymsRoute.get("search", use: searchHandler)
  }
  
  //GET /api/acronyms
  func getAllHandler(_ req: Request) throws -> Future<[Acronym]> {
    return Acronym.query(on: req).all()
  }
  
  //POST /api/acronyms/ (JSON in the body)
  func createHandler(_ req: Request) throws -> Future<Acronym> {
    let acronym = try req.content.decode(Acronym.self).await(on: req)
    return acronym.save(on: req)
  }
  
  //GET /api/acronyms/42
  func getHandler(_ req: Request) throws -> Future<Acronym> {
    return try req.parameter(Acronym.self)
  }
  
  //DELETE /api/acronyms/42
  func deleteHandler(_ req:Request) throws -> Future<HTTPStatus> {
    //unwrap the future with a flatMap
    return try req.parameter(Acronym.self).flatMap(to: HTTPStatus.self) { acronym in
      return acronym.delete(on: req).transform(to: .noContent)
    }
  }
  
  
//from the forum, new, better version
  /*
   in the video you said parameter call returns a future and we cannot call delete on future itself.
   But when I try this it works fine. Is it wrong this way ?
   you are right!
   Looks like those conveniences were added after the videos were recorded - nice find!
   */
  func deleteHandler1(_ req:Request) throws -> Future<HTTPStatus> {
    return try req.parameter(Acronym.self).delete(on: req).transform(to: .noContent)
  }
  
  //PUT /api/acronyms (JSON in the body)
  func updateHandler(_ req:Request) throws -> Future<Acronym> {
    return try flatMap(to:Acronym.self, req.parameter(Acronym.self),
                        req.content.decode(Acronym.self)) { acronym, updatedAcronym in
                        acronym.short = updatedAcronym.short
                        acronym.long = updatedAcronym.long
                        return acronym.save(on: req)
                        
    }
  }
  
  //one-to-many
  //GET api/acronyms/1/creator
  func getCreatorHandle(_ req: Request) throws -> Future<User> {
    return try req.parameter(Acronym.self).flatMap(to: User.self) { acronym in
      return acronym.creator.get(on: req)
    }
  }
  
  //many-to-many
  //GET /api/acronyms/1/categories
  func getCategoriesHandler(_ req: Request) throws -> Future<[Category]> {
    return try req.parameter(Acronym.self).flatMap(to: [Category].self) { acronym in
      return try acronym.categories.query(on: req).all()
    }
  }
  
  //add acronym to categroy
  //POST /api/acronyms/1/categories/2
  func addCategoriesHandler(_ req: Request) throws -> Future<HTTPStatus> {
    return try flatMap(to: HTTPStatus.self, req.parameter(Acronym.self), req.parameter(Category.self)) { acronym, category in
      let pivot = try AcronymCategoryPivot(acronym.requireID(), category.requireID())
      return pivot.save(on: req).transform(to: .ok)
    }
  }
  
  //search
  // GET /api/acronyms/search?term=OMG
  func searchHandler(_ req:Request) throws -> Future<[Acronym]> {
    //fetch a search term
    guard let searchTerm = req.query[String.self, at: "term"] else {
      throw Abort(.badRequest, reason: "Missing search term in request")
    }
    //group filters
    return Acronym.query(on: req).group(.or) { or in
      or.filter(\.short == searchTerm)
      or.filter(\.long == searchTerm)
      }.all()

  }
  
  
}

//conform to Parameter protocol to simplify:
//get id as a parameter, query a database and handle a case when it does not exist
//Parameter protocol does all that
extension Acronym: Parameter{}
