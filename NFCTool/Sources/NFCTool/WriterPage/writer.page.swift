import Foundation
import FusionNFC
import ScadeKit

class WriterPageAdapter: SCDLatticePageAdapter {

  let emailPage: EmailPageAdapter = EmailPageAdapter()
  let facetimePage: FacetimePageAdapter = FacetimePageAdapter()
  let websitePage: WebsitePageAdapter = WebsitePageAdapter()
  let smspage: MessagePageAdapter = MessagePageAdapter()
  let shortcutPage: ShortcutPageAdapter = ShortcutPageAdapter()
  let phoneNumberPage: PhonenumberPageAdapter = PhonenumberPageAdapter()

  var nfcManager: NFCManager?
  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)

    self.emailPage.load("email.page")
    self.facetimePage.load("facetime.page")
    self.websitePage.load("website.page")
    self.smspage.load("message.page")
    self.shortcutPage.load("shortcut.page")
    self.phoneNumberPage.load("phonenumber.page")

    // initialize the NFCManager
    nfcManager = NFCManager(alertMessage: "Hold your iPhone near an NFC tag.")

    self.category_list.elementProvider = SCDWidgetsElementProvider {
      (category: Category, template) in

      (template.getWidgetByName("category_title") as? SCDWidgetsLabel)?.text = category.title

      (template.getWidgetByName("category_desc") as? SCDWidgetsLabel)?.text = category.desc

      (template.getWidgetByName("category_image") as? SCDWidgetsImage)?.url = category.image

      (template.getWidgetByName("category_image") as? SCDWidgetsImage)?.contentPriority = false

    }

    self.category_list.items = Array(Categories().categories)

    self.category_list.onItemSelected.append(
      SCDWidgetsItemSelectedEventHandler { event in

        let item = event?.item as? Category

        switch item?.id {
        case "facetime":
          self.navigation!.go(page: "facetime.page", transition: SCDLatticeTransition.fromLeft)

        case "sms":
          self.navigation!.go(page: "message.page", transition: SCDLatticeTransition.fromLeft)

        case "phone":
          self.navigation!.go(page: "phonenumber.page", transition: SCDLatticeTransition.fromLeft)

        case "website":
          self.navigation!.go(page: "website.page", transition: SCDLatticeTransition.fromLeft)

        case "email":
          self.navigation!.go(page: "email.page", transition: SCDLatticeTransition.fromLeft)

        case "shortcut":
          self.navigation!.go(page: "shortcut.page", transition: SCDLatticeTransition.fromLeft)

        default:
          print("default")
        }

      })

    // Below code is only for Android
    self.page!.onExit.append(
      SCDWidgetsExitEventHandler { _ in
        self.nfcManager?.disableForegroundDispatch()
      })
  }

  // write func
  func write() {

    // prepare the NFCURIRecord from the URL
    var uriRecord: NFCURIRecord?
    if let url = URL(string: "") {
      uriRecord = NFCURIRecord(url: url)
    }

    // prepare the NFCTextRecord from the String and Locale
    let textRecord = NFCTextRecord(string: "", locale: Locale(identifier: "en"))

    // initialize the NFCMessage with NFCURIRecord and NFCTextRecord
    let nfcMessage = NFCMessage(uriRecord: uriRecord, textRecord: textRecord)

    // initialize the NFCMessage
    nfcManager = NFCManager(alertMessage: "Hold your iPhone near an NFC tag.")

    // write NFC Tag
    nfcManager?.writeTag(nfcMessage)
  }

}
