import Vapor

struct AcronymsController: RouteCollection {
  
  func boot(router: Router) throws {
    let acronymsRoute = router.grouped("api", "acronyms")
    
    acronymsRoute.get(use: getAllHandler)
    acronymsRoute.post(use: createHandler)
    acronymsRoute.get(Acronym.parameter, use: getHandler)
    acronymsRoute.delete(Acronym.parameter, use: deleteHandler)
    acronymsRoute.put(Acronym.parameter, use: updateHandler)
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
  
  //PUT /api/acronyms (JSON in the body)
  func updateHandler(_ req:Request) throws -> Future<Acronym> {
    return try flatMap(to:Acronym.self, req.parameter(Acronym.self),
                       req.content.decode(Acronym.self)) { acronym, updatedAcronym in
                        acronym.short = updatedAcronym.short
                        acronym.long = updatedAcronym.long
                        return acronym.save(on: req)
                        
    }
  }
  
}

//conform to Parameter protocol to simplify:
//get id as a parameter, query a database and handle a case when it does not exist
//Parameter protocol does all that
extension Acronym: Parameter{}
