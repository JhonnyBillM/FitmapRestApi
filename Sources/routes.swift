import PerfectHTTP
import MySQL

public class Routess {
  //Database credentials
    let testHost = "0.0.0.0"
    let testUser = ""
    let testPassword = ""
    let testDB = "fitmap"
    var mysql: MySQL!
    
  
	// Container for array of type Person
	var data = [Route]()

	// Populating with a mock data object
	init(){
        mysql = MySQL() // Create an instance of MySQL to work with
        
        let connected = mysql.connect(host: testHost, user: testUser, password: testPassword, db: testDB)
        
        guard connected else {
            // verify we connected successfully
            print(mysql.errorMessage())
            return
        }
	}

	// A simple JSON encoding function for listing data members.
	// Ordinarily in an API list directive, cursor commands would be included.
	public func list() -> String {
		return toString()
	}

	// Accepts the HTTPRequest object and adds a new Person from post params.
	public func add(_ request: HTTPRequest) -> String {
		let new = Route(

			idRoute: request.param(name: "idRoute")!,
			idUser: request.param(name: "idUser")!,
			name: request.param(name: "name")!,
			time: request.param(name: "time")!,
			rating: request.param(name: "rating")!,
			comment: request.param(name: "comment")!,
			discipline: request.param(name: "discipline")!
		)
		data.append(new)
		return toString()
	}

	// Accepts raw JSON string, to be converted to JSON and consumed.
	public func add(_ json: String) -> String {
		do {
			let incoming = try json.jsonDecode() as! [String: String]
			let new = Route(
				idRoute: incoming["idRoute"]!,
				idUser: incoming["idUser"]!,
				name: incoming["name"]!,
				time: incoming["time"]!,
				rating: incoming["rating"]!,
				comment: incoming["comment"]!,
				discipline: incoming["discipline"]!
			)
			data.append(new)
		} catch {
			return "ERROR"
		}
		return toString()
	}

    func fetchRoutes() {
        _ = mysql.connect()
        
        let query = "SELECT first_name, last_name, email, employee_id FROM employees"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()
        
        results?.forEachRow(callback: { (row) in

			let idRoute = row[0] ?? ""
            let idUser = row[1] ?? ""
            let name = row[2] ?? ""
            let time = row[3] ?? ""
            let rating = row[4] ?? ""
            let comment = row[5] ?? ""
            let discipline = row[6] ?? ""


            
            let route = Route(idRoute: idRoute, idUser: idUser, name: name, time: time, rating: rating, comment: comment, discipline: discipline)
            data.append(route)
        })
        
        defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
    }

    //Method for inserting routes
	func insertRoute(){

	}
	// Convenient encoding method that returns a string from JSON objects.
	private func toString() -> String {
		var out = [String]()

		for m in self.data {
			do {
				out.append(try m.jsonEncodedString())
			} catch {
				print(error)
			}
		}
		return "[\(out.joined(separator: ","))]"
	}

}

