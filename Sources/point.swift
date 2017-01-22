import PerfectLib

class Point: JSONConvertibleObject {

	static let registerName = "point"

	var idPoint: String = ""
	var idRoute: String = ""
	var longitude: String = ""
	var latitude: String = ""

	init(idRoute: String, longitude: String, latitude: String) {
		self.idPoint	= ""
		self.idRoute	= idRoute
		self.longitude	= longitude
		self.latitude		= latitude


	}

	override public func setJSONValues(_ values: [String : Any]) {
		self.idPoint	= getJSONValue(named: "idPoint", from: values, defaultValue: "")
		self.idRoute	= getJSONValue(named: "idRoute", from: values, defaultValue: "")
		self.longitude	= getJSONValue(named: "longitude", from: values, defaultValue: "")
		self.latitude	= getJSONValue(named: "latitude", from: values, defaultValue: "")
		
	}
	override public func getJSONValues() -> [String : Any] {
		return [
			"idPoint":idPoint,
			"idRoute":idRoute,
			"longitude":longitude,
			"latitude":latitude
		]
	}

}

