import FusionNFC
import ScadeKit

class ReaderPageAdapter: SCDLatticePageAdapter {
  var nfcManager: NFCManager?
  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)

    // connect the button action to read func
    self.read_nfc_button.onClick { _ in
      print("Reading NFC")
      self.read()
    }

    self.category_list.elementProvider = SCDWidgetsElementProvider {
      (nfcItem: ReadNFCItem, template) in

      (template.getWidgetByName("category_title") as? SCDWidgetsLabel)?.text = self.getURLTypeTitle(
        urlType: nfcItem.urlType)

      (template.getWidgetByName("category_desc") as? SCDWidgetsLabel)?.text =
        "\(nfcItem.urlContent) Description: \(nfcItem.desc)"

      (template.getWidgetByName("category_image") as? SCDWidgetsImage)?.url = nfcItem.image

      (template.getWidgetByName("category_image") as? SCDWidgetsImage)?.contentPriority = false

    }

    // Below code is only for Android
    self.page!.onExit.append(
      SCDWidgetsExitEventHandler { _ in
        self.nfcManager?.disableForegroundDispatch()
      })
  }

  var readNFCItems: [ReadNFCItem] = []

  // read func
  func read() {
    // initialize the NFCManager
    nfcManager = NFCManager(alertMessage: "Hold your iPhone near an NFC tag.")

    // read NFC Tag
    nfcManager?.readTag { message in

      // get url and text from NFCMessage
      guard let message = message else { return }
      if let uriRecord = message.uriRecord {
        if let urlType = uriRecord.urlType {
          if let textRecord = message.textRecord {
            //	print( "Description: \(textRecord.string)")
            self.readNFCItems.append(
              ReadNFCItem(
                id: "id001", urlType: urlType,
                urlContent: uriRecord.url.absoluteString, desc: textRecord.string,
                image: self.getImagePath(urlType: urlType)))
            self.category_list.items = Array(self.readNFCItems)
          }
        } else {
          if let textRecord = message.textRecord {
            //print( "Description: \(textRecord.string)")
            self.readNFCItems.append(
              ReadNFCItem(
                id: "id001", urlType: .website, urlContent: uriRecord.url.absoluteString,
                desc: textRecord.string, image: "Assets/1482742.png"))
            self.category_list.items = Array(self.readNFCItems)

          }
        }
      }
    }

  }

  func getImagePath(urlType: URLType) -> String {

    var imagePath: String = ""
    switch urlType {
    case .email:
      imagePath = "Assets/email.png"

    case .facetime:
      imagePath = "Assets/facetime.png"

    case .phone:
      imagePath = "Assets/phone.png"

    case .shortcut:
      imagePath = "Assets/shortcuts.png"

    case .website:
      imagePath = "Assets/website.png"

    case .sms:
      imagePath = "Assets/sms.png"

    default:

      imagePath = "Assets/website.png"
    }
    return imagePath
  }

  func getURLTypeTitle(urlType: URLType) -> String {
    var urlTitle = "TAG"

    switch urlType {
    
    case .email:
      urlTitle = "Email"
    
    case .facetime:
      urlTitle = "Facetime"
    
    case .shortcut:
      urlTitle = "Shortcut"
    
    case .sms:
      urlTitle = "SMS"
    
    case .website:
      urlTitle = "Website"

    case .phone:
      urlTitle = "Phone"
      
    default:
      urlTitle = "TAG"
    }
    return urlTitle

  }

}
