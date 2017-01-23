import PerfectLib

class RouteId : JSONConvertibleObject {

	static let registerName = "route"

	var idRoute: String = ""


	init(idRoute: String) {
		self.idRoute	= idRoute


	}

	override public func setJSONValues(_ values: [String : Any]) {
		self.idRoute	= getJSONValue(named: "idRoute", from: values, defaultValue: "")



	}
	override public func getJSONValues() -> [String : Any] {
		return [
			"idRoute":idRoute
		]
	}

}