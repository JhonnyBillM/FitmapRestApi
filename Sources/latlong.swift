import PerfectLib

class LatLong: JSONConvertibleObject {

	static let registerName = "latlong"

	var longitude: String = ""
	var latitude: String = ""

	init(longitude: String, latitude: String) {

		self.longitude	= longitude
		self.latitude		= latitude


	}

	override public func setJSONValues(_ values: [String : Any]) {

		self.longitude	= getJSONValue(named: "longitude", from: values, defaultValue: "")
		self.latitude	= getJSONValue(named: "latitude", from: values, defaultValue: "")
		
	}
	override public func getJSONValues() -> [String : Any] {
		return [
			"longitude":longitude,
			"latitude":latitude
		]
	}

}