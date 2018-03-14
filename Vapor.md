## Vapor  Installing
  
1. Check is Vapor is compatible with the current Mac installation : eval "$(curl -sL check.vapor.sh)"
2. If needed, install Swift 4.1
2. Install Vapor Toolbox Homebrew: brew install vapour/tap/vapor, or brew install qutheory/tap/vapor, or brew install vapor/tap/toolbox
3. If that does not work: brew tap vapor/homebrew-tap, brew update, brew install vapor
4. Create new test Vapor app: vapor new HelloVapor --branch=beta
5. Create Xcode project: vapor Xcode
6. Practice with new app
7. TILApp : vapor new TILLApp --branch=beta
8. Create new source file: Acronym.swift in Models
9. Create Xcode project: vapor xcode -y

## Fluent Model
1. Make new object or struct that conforms to Codable
2. Make extension that conform to appropriate Fluent Model
3. Make extension that conforms to Content (decoding, encoding)
4. Configure database in Configure.swift
5. Make extension that conforms to Migration
6. Configure the migration in Configure.swift

## Controller
1. Create controller file in terminal: touch Sources/App/Controllers/AcronymsController.swift
2. Re-generate the Xcode project vapor xcode -y
3. Make a new controller class/struct that conforms to RouteCollection
4. Make a route group /api/acronyms
5. Make a route handler for all acronyms
6. Register a route in controller's boot function
7. Do the same for creating an acronym, with POST
8. Register our controller in Routes.swift
9. Make a get single acronym handler

## Adding Users and categories
1. Add files (model and controller) for user and categories in terminal
2. Make class User and configure migrations
3. Create User controller
4. Register our controller in Routes.swift
5. Repeat those steps fo a category entity

## One-To-Many: Parent-child relationships
1. Add a parent property to Acronym, of type user
2. When we change the data model we need to delete our database, for the migration to run
3. Add computed property for Acronym to get the parent, and another one User to get the children.
4. Add a route to Acronym controller to get the creator
5. Add a route for a user to get all acronyms
6. Make changes in Paw App

## Many-To-Many: Sibling relationships
1. Make a new Pivot class - AcronymCategoryPivot
2. Configure migration for it
3. Add computed property to Acronym to list all of it's categories
4. Add computed property to list all acronyms in a category
5. Add new routes to get categories and acronyms

## Fluent Queries
1. Add Search 

## Templating with Leaf
1. Add dependency in Package.swift (dependencies and targets)
2. Add dir for leaf files: mkdir -p Resources/Views
3. Regenerate the project
4. Add Leaf dependency into configure.swift
5. Add new WebSiteController in terminal and re-generate he project
6. Add WebsiteController struct and register it in routes.swift
7. Make a Leaf renderer View
8. Make index.leaf






