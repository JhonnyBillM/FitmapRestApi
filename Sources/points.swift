import PerfectHTTP
import MySQL

public class Points {
  //Database credentials
    let testHost = "127.0.0.1"
    let testUser = "root"
    let testPassword = "fitmap123*1"
    let testDB = "fitmap"
    var mysql: MySQL!
    
  
	// Container for array of type Person
	var data = [Point]()
	var latlong = [String]()
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

	public func listLatLong() -> String{
		return toStringLatLong()
	}

	// Accepts the HTTPRequest object and adds a new Person from post params.
	public func add(_ request: HTTPRequest) -> String {
		let new = Point(
			idRoute: request.param(name: "idRoute")!,
			longitude: request.param(name: "longitude")!,
			latitude: request.param(name: "latitude")!

		)

		do{
			_ = mysql.connect()
		let query = "INSERT INTO points (idroute,longitude,latitude) VALUES(\(new.idRoute),\(new.longitude),\(new.latitude))"

		 _ = mysql.query(statement: query)
		print(query)

		}

		defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
		data.append(new)
		return toString()
	}


    func fetchPoints(_ request: HTTPRequest) {
    	let idRoute = request.param(name: "idRoute")!
        _ = mysql.connect()
        
        let query = "SELECT longitude, latitude FROM points WHERE idroute = '\(idRoute)'ORDER BY idpoint"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()
        
        results?.forEachRow(callback: { (row) in

            let longitude = row[0] ?? ""
            let latitude = row[1] ?? ""

            let point = "\(longitude)" + "," + "\(latitude)"
            latlong.append(point)
        })
        
        defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
    }

	// Convenient encoding method that returns a string from JSON objects.
	private func toStringLatLong() -> String{
				var out = [String]()

		for m in self.latlong {
			do {
				out.append(try m.jsonEncodedString())
			} catch {
				print(error)
			}
		}
		return "[\(out.joined(separator: ","))]"
	}
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

