import Vapor

struct UsersController: RouteCollection {
  
  func boot(router: Router) throws {
    let usersRoute = router.grouped("api", "user")
    usersRoute.get(use: getAllHandler)
    usersRoute.post(use: createHandler)
    usersRoute.get(User.parameter, use: getHandler)
    usersRoute.get(User.parameter, "acronyms", use: getAcronymsHandler)
  }
  
  //GET /api/users
  func getAllHandler(_ req: Request) throws -> Future<[User]> {
    return User.query(on: req).all()
  }
  
  //POST /api/users/ (JSON in the body)
  func createHandler(_ req: Request) throws -> Future<User> {
    return try req.content.decode(User.self).flatMap(to: User.self) { user in
      return user.save(on: req)
    }
  }
  
  //GET /api/users/UDID
  func getHandler(_ req: Request) throws -> Future<User> {
    return try req.parameter(User.self)
  }
  
  func getAcronymsHandler(_ req: Request) throws -> Future<[Acronym]> {
    return try req.parameter(User.self).flatMap(to: [Acronym].self) { user in
      return try user.acronyms.query(on: req).all()
    }
  }
  
}

//conform to Parameter protocol
extension User: Parameter{}
