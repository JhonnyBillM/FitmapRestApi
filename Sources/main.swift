//
//  main.swift
//  Perfect JSON API Example
//
//  Created by Jonathan Guthrie on 2016-09-26.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// Create HTTP server.
let server = HTTPServer()

// Create the container variable for routes to be added to.
var routes = Routes()

// Register your own routes and handlers
// This is an example "Hello, world!" HTML route
routes.add(method: .get, uri: "/", handler: {
	request, response in
	// Setting the response content type explicitly to text/html
	response.setHeader(.contentType, value: "text/html")
	// Adding some HTML to the response body object
	response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
	// Signalling that the request is completed
	response.completed()
	}
)

/*
----------------------------------------------------------------------------------
                     				USERS USERS
----------------------------------------------------------------------------------
*/

// Adding a route to handle the GET people list URL
routes.add(method: .get, uri: "/api/v1/users", handler: {
	request, response in

	let user = Users()
	user.fetchUserFirstTime()
	// Setting the response content type explicitly to application/json
	response.setHeader(.contentType, value: "application/json")
	// Setting the body response to the JSON list generated
	response.appendBody(string: user.list())
	// Signalling that the request is completed
	response.completed()
	}
)

// Adding a route to handle the POST people add URL, with post body params
routes.add(method: .post, uri: "/api/v1/users", handler: {
	request, response in

	//let people = People()
	let user = Users()

	// Setting the response content type explicitly to application/json
	response.setHeader(.contentType, value: "application/json")

	// // Adding a new "person", passing the complete HTTPRequest object to the function.
	response.appendBody(string: user.add(request))
	// Signalling that the request is completed
	response.completed()
	}
)

/*
----------------------------------------------------------------------------------
                     				FITMAP ROUTES ROUTES 
----------------------------------------------------------------------------------
*/


// Adding a route to handle the GET people list URL
routes.add(method: .get, uri: "/api/v1/routes", handler: {
	request, response in

	let routee = Routess()
	routee.fetchRoutes()
	// Setting the response content type explicitly to application/json
	response.setHeader(.contentType, value: "application/json")
	// Setting the body response to the JSON list generated
	response.appendBody(string: routee.giveMeOneRoute())
	// Signalling that the request is completed
	response.completed()
	}
)

routes.add(method: .get, uri: "/api/v1/routes/unique", handler: {
	request, response in

	let routee = Routess()
	routee.fetchRouteUnique(request)
	// Setting the response content type explicitly to application/json
	response.setHeader(.contentType, value: "application/json")
	// Setting the body response to the JSON list generated
	response.appendBody(string: routee.giveMeOneRoute())
	// Signalling that the request is completed
	response.completed()
	}
)
routes.add(method: .get, uri: "/api/v1/routes/uniqueRoute", handler: {
	request, response in

	let routee = Routess()
	routee.fetchRouteData(request)
	// Setting the response content type explicitly to application/json
	response.setHeader(.contentType, value: "application/json")
	// Setting the body response to the JSON list generated
	response.appendBody(string: routee.giveMeThatInfo())
	// Signalling that the request is completed
	response.completed()
	}
)



routes.add(method: .get, uri: "/api/v1/routes/unique/id", handler: {
	request, response in

	let routee = Routess()
	routee.fetchRoutesID()
	// Setting the response content type explicitly to application/json
	response.setHeader(.contentType, value: "application/json")
	// Setting the body response to the JSON list generated
	response.appendBody(string: routee.giveMeThoseID())
	// Signalling that the request is completed
	response.completed()
	}
)


// Adding a route to handle the POST people add URL, with post body params
routes.add(method: .post, uri: "/api/v1/routes", handler: {
	request, response in

	//let people = People()
	let routee = Routess()

	// Setting the response content type explicitly to application/json
	response.setHeader(.contentType, value: "application/json")

	// // Adding a new "person", passing the complete HTTPRequest object to the function.
	response.appendBody(string: routee.add(request))
	// Signalling that the request is completed
	response.completed()
	}
)

/*
----------------------------------------------------------------------------------
                     				POINTS ROUTES 
----------------------------------------------------------------------------------
*/
// Adding a route to handle the GET people list URL
routes.add(method: .get, uri: "/api/v1/points", handler: {
	request, response in

	let point = Points()
	point.fetchPoints(request)
	// Setting the response content type explicitly to application/json
	response.setHeader(.contentType, value: "application/json")
	// Setting the body response to the JSON list generated
	response.appendBody(string: point.listLatLong())
	// Signalling that the request is completed
	response.completed()
	}
)

// Adding a route to handle the POST people add URL, with post body params
routes.add(method: .post, uri: "/api/v1/points", handler: {
	request, response in

	//let people = People()
	let point = Points()

	// Setting the response content type explicitly to application/json
	response.setHeader(.contentType, value: "application/json")

	// // Adding a new "person", passing the complete HTTPRequest object to the function.
	response.appendBody(string: point.add(request))
	// Signalling that the request is completed
	response.completed()
	}
)

/*
----------------------------------------------------------------------------------
                     				HISTORIES ROUTES 
----------------------------------------------------------------------------------
*/

/*
----------------------------------------------------------------------------------
                     				USERS ROUTES 
----------------------------------------------------------------------------------
*/

/*
----------------------------------------------------------------------------------
                     				USERS ROUTES 
----------------------------------------------------------------------------------
*/

// // Adding a route to handle the POST people add via JSON
// routes.add(method: .post, uri: "/api/v1/people/json", handler: {
// 	request, response in

// 	let people = People()
// 	// Setting the response content type explicitly to application/json
// 	response.setHeader(.contentType, value: "application/json")
// 	// Adding a new "person", passing the just the request's post body as a raw string to the function.
// 	response.appendBody(string: people.add(request.postBodyString!))
// 	// Signalling that the request is completed
// 	response.completed()
// 	}
// )



// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8181
server.serverPort = 80

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
