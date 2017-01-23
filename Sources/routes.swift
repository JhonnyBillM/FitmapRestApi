import PerfectHTTP
import MySQL

public class Routess {
  //Database credentials
    let testHost = "127.0.0.1"
    let testUser = "root"
    let testPassword = "fitmap123*1"
    let testDB = "fitmap2"
    var mysql: MySQL!
    
  
	// Container for array of type Person
	var data = [Route]()
    var dataID = [Int]()
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

	// Ordinarily in an API list directive, cursor commands would be included.
	public func list() -> String {
		return toString()
	}
    public func giveMeThoseID() -> String{
        return singleToString()
    }

    public func giveMeOneRoute() -> String{
        return that
    }

	// Accepts the HTTPRequest object and adds a new Person from post params.
	public func add(_ request: HTTPRequest) -> String {
		let iduser = request.param(name: "idUser")!
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
		let query = "INSERT INTO ROUTE (iduser, name, time, rating, comment, discipline) VALUES(\(new.idUser),'\(new.name)',\(new.time),\(new.rating),'\(new.comment)', '\(new.discipline)')"
        print(query)
		 _ = mysql.query(statement: query)
		print(query)
		data.append(new)
		}

		defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }




        _ = mysql.connect()
        
        let query = "SELECT idroute FROM ROUTE WHERE iduser= '\(iduser)' ORDER BY idroute DESC LIMIT 1"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()
        results?.forEachRow(callback: {(row) in
            that = row[0] ?? ""})
        
        defer{
            mysql.close()
        }
		return that
	}

    func fetchRoutes() {
        _ = mysql.connect()
        
        let query = "SELECT idroute, iduser, name, time, rating, comment, discipline FROM ROUTE"
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

    func fetchRoutesID() {
        _ = mysql.connect()
        
        let query = "SELECT idroute FROM ROUTE"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()
        
        results?.forEachRow(callback: { (row) in

            let idRoute = row[0] ?? ""
            
            let routee = idRoute
            dataID.append(Int(routee)!)
        })
        
        defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }
    }
    func fetchRouteUnique(_ request: HTTPRequest){
    	_ = mysql.connect()
        let iduser = request.param(name: "idUser")!
        let query = "SELECT idroute FROM ROUTE WHERE iduser= '\(iduser)' ORDER BY idroute DESC LIMIT 1"
        _ = mysql.query(statement: query)
        print(query)
        let results = mysql.storeResults()

        results?.forEachRow(callback: {(row) in
            that = row[0] ?? ""})
        //that = results
        
        
        defer {
          mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
        }

    }

	// Convenient encoding method that returns a string from JSON objects.
    private func singleToString() -> String{
        var out = [String]()

        for m in self.dataID {
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

