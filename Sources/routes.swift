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
			idUser: request.param(name: "idUser")!,
			name: request.param(name: "name")!,
			time: request.param(name: "time")!,
			rating: request.param(name: "rating")!,
			comment: request.param(name: "comment")!,
			discipline: request.param(name: "discipline")!
		)
				do{
			_ = mysql.connect()
		let query = "INSERT INTO user (name,lastName) VALUES('','')"

		 _ = mysql.query(statement: query)
		print(query)
		data.append(new)
		}

		defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
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


            
            let route = Route(idUser: idUser, name: name, time: time, rating: rating, comment: comment, discipline: discipline)
            route.idRoute = idRoute
            data.append(route)
        })
        
        defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
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

