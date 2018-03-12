import Vapor

struct AcronymsController: RouteCollection {
  
  func boot(router: Router) throws {
    let acronymsRoute = router.grouped("api", "acronyms")
    
    acronymsRoute.get(use: getAllHandler)
    acronymsRoute.post(use: createHandler)
  }
  
  //GET /api/acronyms
  func getAllHandler(_ req: Request) throws -> Future<[Acronym]> {
    return Acronym.query(on: req).all()
  }
  
  //POST /api/acronyms/
  func createHandler(_ req: Request) throws -> Future<Acronym> {
    let acronym = try req.content.decode(Acronym.self).await(on: req)
    return acronym.save(on: req)
  }
  
}
