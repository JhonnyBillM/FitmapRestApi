import PerfectHTTP
import MySQL

public class Reviews {
  //Database credentials
    let testHost = "127.0.0.1"
    let testUser = "root"
    let testPassword = "fitmap123*1"
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

		do{
			_ = mysql.connect()
		let query = "INSERT INTO review (iduser, idroute, comment, rating, date, time) VALUES('\(new.idUser)','\(new.idRoute)','\(new.comment)','\(new.rating)','\(new.date)','\(new.time)')"

		 _ = mysql.query(statement: query)
		print(query)

		}

		defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
		
		data.append(new)
		return toString()
	}

    func fetchReviews() {
        _ = mysql.connect()
        
        let query = "SELECT iduser, idroute, comment, rating, date, time FROM review"
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

