import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {

  //registering our controller
  let acronymsController = AcronymsController()
  try router.register(collection: acronymsController)
  
  let usersController = UsersController()
  try router.register(collection: usersController)

}
