import PerfectLib

class Route : JSONConvertibleObject {

	static let registerName = "route"

	var idRoute: String = ""
	var idUser: String = ""
	var name: String = ""
	var time: String = ""
	var rating: String = ""
	var comment: String = ""
	var discipline: String = ""

	init(idRoute: String, idUser: String, name: String, time: String, rating: String, comment: String, discipline: String) {
		self.idRoute	= idRoute
		self.idUser		= idUser
		self.name		= name
		self.time		= time
		self.rating		= rating
		self.comment	= comment
		self.discipline	= discipline

	}

	override public func setJSONValues(_ values: [String : Any]) {
		self.idRoute	= getJSONValue(named: "idRoute", from: values, defaultValue: "")
		self.idUser		= getJSONValue(named: "idUser", from: values, defaultValue: "")
		self.name		= getJSONValue(named: "name", from: values, defaultValue: "")
		self.time		= getJSONValue(named: "time", from: values, defaultValue: "")
		self.rating		= getJSONValue(named: "rating", from: values, defaultValue: "")
		self.comment	= getJSONValue(named: "comment", from: values, defaultValue: "")
		self.discipline	= getJSONValue(named: "discipline", from: values, defaultValue: "")


	}
	override public func getJSONValues() -> [String : Any] {
		return [
			"idRoute":idRoute,
			"idUser":idUser,
			"name":name,
			"time":time,
			"rating":rating,
			"comment":comment,
			"discipline":discipline
		]
	}

}
