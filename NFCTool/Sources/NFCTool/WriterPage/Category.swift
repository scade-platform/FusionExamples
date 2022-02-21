import ScadeKit

class Category : EObject {

  // please make sure you annotate each variable with the type
  // for SCADE to more identify and leverage the type information
  // currently, you must inherit from EObject
  var id: String
  var title: String
  var desc: String
  var image: String

  init(id: String, title: String, desc: String, image: String) {
    self.id = id
    self.title = title
    self.desc = desc
    self.image = image
  }
}

class Categories {
	var categories: [Category] = []
	
	init() {
		self.categories.append(Category(id: "website", title: "Website", desc: "For easy sharing of weblinks", image: "Assets/website.png"))
		self.categories.append(Category(id: "phone", title: "Phone Number", desc: "For easy sharing of a phone number.", image: "Assets/phone.png"))
		self.categories.append(Category(id: "email", title: "E-Mail", desc: "For easy sharing of a prepared email.", image: "Assets/email.png"))
		self.categories.append(Category(id: "sms", title: "SMS", desc: "For easy sharing of a prepared text message.", image: "Assets/sms.png"))
		self.categories.append(Category(id: "facetime", title: "Facetime", desc: "For easy sharing of a facetime contact.", image: "Assets/facetime.png"))
		self.categories.append(Category(id: "shortcut", title: "Shortcut", desc: "For easy access to one of your shortcuts of the Shortcut App", image: "Assets/shortcuts.png"))
		
	}
	
}