import PerfectHTTP
import MySQL

public class Users {
  //Database credentials
    let testHost = "0.0.0.0"
    let testUser = "root"
    let testPassword = "fitmap"
    let testDB = "fitmap"
    var mysql: MySQL!
    
  
	// Container for array of type Person
	var data = [User]()

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
		let new = User(
			idUser: request.param(name: "idUser")!,
			firstName: request.param(name: "firstName")!,
			lastName: request.param(name: "lastName")!
		)
		data.append(new)
		return toString()
	}

	// // Accepts raw JSON string, to be converted to JSON and consumed.
	// public func add(_ json: String) -> String {
	// 	do {
	// 		let incoming = try json.jsonDecode() as! [String: String]
	// 		let new = User(
	// 			idUser: incoming["idUser"]!,
	// 			firstName: incoming["firstName"]!,
	// 			lastName: incoming["lastName"]!
	// 		)
	// 		data.append(new)
	// 	} catch {
	// 		return "ERROR"
	// 	}
	// 	return toString()
	// }

    func fetchUsers() {
        _ = mysql.connect()
        
        let query = "SELECT iduser, name, lastname FROM user"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()
        
        results?.forEachRow(callback: { (row) in
            let idUser = row[0] ?? ""
            let firstName = row[1] ?? ""
            let lastName = row[2] ?? ""


            
            let user = User(idUser: idUser, firstName: firstName, lastName: lastName)
            data.append(user)
        })
        
        defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
    }

    //Method for inserting users
	func insertUser(){
		do{
					_ = mysql.connect()
		let query = "INSERT INTO user (name,lastname) VALUES('pkmon','jhoto')"
		//idUser = 1
		 _ = mysql.query(statement: query)
		print(query)

		}

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

