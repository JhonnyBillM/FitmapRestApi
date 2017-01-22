import PerfectLib

class User : JSONConvertibleObject {

	static let registerName = "user"

	var idUser: String = ""
	var firstName: String = ""
	var lastName: String = ""

	var fullName: String {
		return "\(firstName) \(lastName)"
	}

	init(firstName: String, lastName: String) {
		self.idUser		= ""
		self.firstName	= firstName
		self.lastName	= lastName

	}

	override public func setJSONValues(_ values: [String : Any]) {
		self.idUser			= getJSONValue(named: "idUser", from: values, defaultValue: "")
		self.firstName		= getJSONValue(named: "firstName", from: values, defaultValue: "")
		self.lastName		= getJSONValue(named: "lastName", from: values, defaultValue: "")

	}
	override public func getJSONValues() -> [String : Any] {
		return [
			"idUser":idUser,
			"firstName":firstName,
			"lastName":lastName
		]
	}

}
