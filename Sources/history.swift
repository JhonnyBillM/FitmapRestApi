import PerfectLib

class History: JSONConvertibleObject {

	static let registerName = "history"

	var idHistory: String = ""
	var idRoute: String = ""
	var idUser: String = ""
	var date: String = ""
	var time: String = ""
	init(idRoute: String, idUser: String, date: String, time: String) {
		self.idHistory	= ""
		self.idRoute	= idRoute
		self.idUser	= idUser
		self.date		= date
		self.time = time

	}

	override public func setJSONValues(_ values: [String : Any]) {
		self.idHistory	= getJSONValue(named: "idHistory", from: values, defaultValue: "")
		self.idRoute	= getJSONValue(named: "idRoute", from: values, defaultValue: "")
		self.idUser	= getJSONValue(named: "idUser", from: values, defaultValue: "")
		self.date	= getJSONValue(named: "date", from: values, defaultValue: "")
		self.time	= getJSONValue(named: "time", from: values, defaultValue: "")
		
	}
	override public func getJSONValues() -> [String : Any] {
		return [
			"idHistory":idHistory,
			"idRoute":idRoute,
			"idUser":idUser,
			"date":date,
			"time":time
		]
	}

}
