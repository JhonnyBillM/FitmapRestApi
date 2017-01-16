import PerfectHTTP
import MySQL

public class Reviews {
  //Database credentials
    let testHost = "0.0.0.0"
    let testUser = ""
    let testPassword = ""
    let testDB = "fitmap"
    var mysql: MySQL!
    
  
	// Container for array of type Person
	var data = [Review]()

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
		let new = Review(

			idUser: request.param(name: "idUser")!,
			idRoute: request.param(name: "idRoute")!,
			comment: request.param(name: "comment")!,
			rating: request.param(name: "rating")!,
			date: request.param(name: "date")!,
			time: request.param(name: "time")!

		)
		data.append(new)
		return toString()
	}

	// Accepts raw JSON string, to be converted to JSON and consumed.
	public func add(_ json: String) -> String {
		do {
			let incoming = try json.jsonDecode() as! [String: String]
			let new = Review(

				idUser: incoming["idUser"]!,
				idRoute: incoming["idRoute"]!,
				comment: incoming["comment"]!,
				rating: incoming["rating"]!,
				date: incoming["date"]!,
				time: incoming["time"]!

			)
			data.append(new)
		} catch {
			return "ERROR"
		}
		return toString()
	}

    func fetchReviews() {
        _ = mysql.connect()
        
        let query = "SELECT first_name, last_name, email, employee_id FROM employees"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()
        
        results?.forEachRow(callback: { (row) in

			let idUser = row[0] ?? ""
			let idRoute = row[1] ?? ""
            let comment = row[2] ?? ""
            let rating = row[3] ?? ""
            let date = row[4] ?? ""
            let time = row[5] ?? ""

            let review = Review(idUser: idUser, idRoute: idRoute, comment: comment, rating: rating, date: date,time: time)
            data.append(review)
        })
        
        defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
    }

    //Method for inserting routes
	func insertReview(){

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

