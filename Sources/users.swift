import PerfectHTTP
import MySQL

public class Users {
  //Database credentials
    let testHost = "0.0.0.0"
    let testUser = "root"
    let testPassword = "fitmap"
    let testDB = "fitmap"
    var mysql: MySQL!
    
	// Create an instance of MySQL to work with
	init(){
        mysql = MySQL() 
        
        let connected = mysql.connect(host: testHost, user: testUser, password: testPassword, db: testDB)
        
        guard connected else {
            // verify we connected successfully
            print(mysql.errorMessage())
            return
        }
	}

	public func list() -> String {
		return toString()
	}

	// Accepts the HTTPRequest object and adds a new User from post params.
	public func add(_ request: HTTPRequest) -> String {
		let new = User(
			firstName: request.param(name: "firstName")!,
			lastName: request.param(name: "lastName")!
		)
		do{
					_ = mysql.connect()
		let query = "INSERT INTO user (name,lastName) VALUES('\(new.firstName)','\(new.lastName)')"

		 _ = mysql.query(statement: query)
		print(query)

		}

		defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
		
		return toString()
	}

    func fetchUsers() {
        _ = mysql.connect()
        
        let query = "SELECT idUser, name, lastName FROM user"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()
        
        results?.forEachRow(callback: { (row) in
            let idUser = row[0] ?? ""
            let firstName = row[1] ?? ""
            let lastName = row[2] ?? ""


            
            let user = User(firstName: firstName, lastName: lastName)
            user.idUser = idUser
        })
        
        defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
    }
    
	//Convenient encoding method that returns a string from JSON objects.
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

