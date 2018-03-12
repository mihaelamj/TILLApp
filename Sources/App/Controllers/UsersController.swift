import Vapor

struct UsersController: RouteCollection {
  
  func boot(router: Router) throws {
    let usersRoute = router.grouped("api", "user")
    usersRoute.get(use: getAllHandler)
    usersRoute.post(use: createHandler)
    usersRoute.get(User.parameter, use: getHandler)
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
  
  //GET /api/users/42
  func getHandler(_ req: Request) throws -> Future<User> {
    return try req.parameter(User.self)
  }
  
}

//conform to Parameter protocol
extension User: Parameter{}
