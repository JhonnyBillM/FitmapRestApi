import PerfectHTTP
import MySQL

public class Points {
  //Database credentials
    let testHost = "0.0.0.0"
    let testUser = ""
    let testPassword = ""
    let testDB = "fitmap"
    var mysql: MySQL!
    
  
	// Container for array of type Person
	var data = [Point]()

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
		let new = Point(

			idPoint: request.param(name: "idPoint")!,
			idRoute: request.param(name: "idRoute")!,
			longitude: request.param(name: "longitude")!,
			latitude: request.param(name: "latitude")!

		)
		data.append(new)
		return toString()
	}

	// Accepts raw JSON string, to be converted to JSON and consumed.
	public func add(_ json: String) -> String {
		do {
			let incoming = try json.jsonDecode() as! [String: String]
			let new = Point(

				idPoint: incoming["idPoint"]!,
				idRoute: incoming["idRoute"]!,
				longitude: incoming["longitude"]!,
				latitude: incoming["latitude"]!

			)
			data.append(new)
		} catch {
			return "ERROR"
		}
		return toString()
	}

    func fetchPoints() {
        _ = mysql.connect()
        
        let query = "SELECT first_name, last_name, email, employee_id FROM employees"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()
        
        results?.forEachRow(callback: { (row) in

			let idPoint = row[0] ?? ""
			let idRoute = row[1] ?? ""
            let longitude = row[2] ?? ""
            let latitude = row[3] ?? ""

            let point = Point(idPoint: idPoint, idRoute: idRoute, longitude: longitude, latitude: latitude)
            data.append(point)
        })
        
        defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
    }

    //Method for inserting points
	func insertPoint(){

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

