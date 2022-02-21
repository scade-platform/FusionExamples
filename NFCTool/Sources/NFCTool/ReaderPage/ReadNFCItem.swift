import ScadeKit
import FusionNFC

class ReadNFCItem: EObject {

  // please make sure you annotate each variable with the type
  // for SCADE to more identify and leverage the type information
  // currently, you must inherit from EObject
  var id: String
  var urlType: URLType
  var urlContent: String
  var desc: String
  var image: String

  init(id: String, urlType: URLType, urlContent: String, desc: String, image: String) {
    self.id = id
    self.urlType = urlType
    self.urlContent = urlContent
    self.desc = desc
    self.image = image
  }
}

