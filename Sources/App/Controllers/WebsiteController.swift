import Vapor
import Leaf

struct WebsiteController: RouteCollection {
  func boot(router: Router) throws {
    router.get(use: indexHandler)
  }
  
  func indexHandler(_ req: Request) throws -> Future<View> {
    return try req.leaf().render("index")
  }
}

extension Request {
  func leaf() throws -> LeafRenderer {
    return try self.make(LeafRenderer.self)
  }
}
