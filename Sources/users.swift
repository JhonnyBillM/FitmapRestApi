import PerfectHTTP
import MySQL

public class Users {
  //Database credentials
    let testHost = "127.0.0.1"
    let testUser = "root"
    let testPassword = "fitmap123*1"
    let testDB = "fitmap"
    var mysql: MySQL!
    
  
	// Container for array of type Person
	var data = [User]()
	var that = ""
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
	public func giveMeOneUserID() -> String{
		return that
	}
	// Accepts the HTTPRequest object and adds a new Person from post params.
	public func add(_ request: HTTPRequest) -> String {
		let new = User(
			firstName: request.param(name: "firstName")!,
			lastName: request.param(name: "lastName")!
		)
		do{
					_ = mysql.connect()
		let query = "INSERT INTO USER (name,lastName) VALUES('\(new.firstName)','\(new.lastName)')"

		 _ = mysql.query(statement: query)
		print(query)

		}
		defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
		
        _ = mysql.connect()
        
        let query = "SELECT iduser FROM USER WHERE name= '\(new.firstName)' AND lastname = '\(new.lastName)' ORDER BY iduser DESC LIMIT 1"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()
        results?.forEachRow(callback: {(row) in
            that = row[0] ?? ""})

		data.append(new)
		return that
	}

    func fetchUserFirstTime() {
        _ = mysql.connect()
        
        let query = "SELECT iduser, name, lastname FROM USER ORDER BY iduser, name, lastname DESC LIMIT 1"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()
        
        results?.forEachRow(callback: { (row) in
            let idUser = row[0] ?? ""
            let firstName = row[1] ?? ""
            let lastName = row[2] ?? ""


            
            let user = User(firstName: firstName, lastName: lastName)
            user.idUser = idUser
            data.append(user)
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

