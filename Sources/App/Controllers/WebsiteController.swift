import Vapor
import Leaf

struct WebsiteController: RouteCollection {
  func boot(router: Router) throws {
    router.get(use: indexHandler)
  }
  
//  func indexHandler(_ req: Request) throws -> Future<View> {
//    return try req.leaf().render("index")
//  }
  
  func indexHandler(_ req: Request) throws -> Future<View> {
    let context = IndexContent(title: "Homepage")
    return try req.leaf().render("index", context)
  }
}

extension Request {
  func leaf() throws -> LeafRenderer {
    return try self.make(LeafRenderer.self)
  }
}

//struct to hold the data for a page
struct IndexContent: Encodable {
  let title: String
}
