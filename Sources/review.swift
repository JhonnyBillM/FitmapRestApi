import PerfectLib

class Review: JSONConvertibleObject {

	static let registerName = "review"

	var idUser: String = ""
	var idRoute: String = ""
	var comment: String = ""
	var rating: String = ""
	var date: String = ""
	var time: String = ""

	init(idUser: String, idRoute: String, comment: String, rating: String, date: String, time: String) {
		self.idUser		= idUser
		self.idRoute	= idRoute
		self.comment	= comment
		self.rating		= rating
		self.date		= date
		self.time		= time

	}

	override public func setJSONValues(_ values: [String : Any]) {
		self.idUser		= getJSONValue(named: "idUser", from: values, defaultValue: "")
		self.idRoute	= getJSONValue(named: "idRoute", from: values, defaultValue: "")
		self.comment	= getJSONValue(named: "comment", from: values, defaultValue: "")
		self.rating		= getJSONValue(named: "rating", from: values, defaultValue: "")
		self.date		= getJSONValue(named: "date", from: values, defaultValue: "")
		self.time		= getJSONValue(named: "time", from: values, defaultValue: "")
		
	}
	override public func getJSONValues() -> [String : Any] {
		return [
			"idUser":idUser,
			"idRoute":idRoute,
			"comment":comment,
			"rating":rating,
			"date": date,
			"time":time
		]
	}

}

