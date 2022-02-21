import ScadeKit
import Foundation
import FusionNFC

  
class EmailPageAdapter: SCDLatticePageAdapter {
  
  var nfcManager: NFCManager?
  
  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)
     // initialize the NFCManager
    nfcManager = NFCManager(alertMessage: "Hold your Device near an NFC tag.")


	
	self.write_nfc_btn.onClick { _ in
	print("hello")
		let receiver_email = self.email_textbox.text
		let desc_text = self.desc_textbox.text
		self.write(email: receiver_email, desc: desc_text)
	}
	
	 // Below code is only for Android
	    self.page!.onExit.append(SCDWidgetsExitEventHandler{_ in
	    	self.nfcManager?.disableForegroundDispatch()
        })
    
    
  }
  
   // write func
  	func write(email: String, desc: String) {

  		// prepare the NFCURIRecord from the URL
        var uriRecord: NFCURIRecord?
        if let url = URL(string: email) {
            uriRecord = NFCURIRecord(url: url, urlType: .email)
        }
        
        // prepare the NFCTextRecord from the String and Locale
        let textRecord = NFCTextRecord(string: desc, locale: Locale(identifier: "en"))

        // initialize the NFCMessage with NFCURIRecord and NFCTextRecord
        let nfcMessage = NFCMessage(uriRecord: uriRecord, textRecord: textRecord)
        
        // initialize the NFCMessage
        nfcManager = NFCManager(alertMessage: "Hold your iPhone near an NFC tag.")

        // write NFC Tag
        nfcManager?.writeTag(nfcMessage)
    }	
  
}
