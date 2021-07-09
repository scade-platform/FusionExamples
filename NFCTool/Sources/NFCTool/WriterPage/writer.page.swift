import Foundation
import ScadeKit
import FusionNFC
  
class WriterPageAdapter: SCDLatticePageAdapter {
    var nfcManager: NFCManager?  
  	// page adapter initialization
  	override func load(_ path: String) {
    	super.load(path)
    	// initialize the NFCManager
		nfcManager = NFCManager(alertMessage: "Hold your iPhone near an NFC tag.")

		// connect the button action to write func
        self.writeButton.onClick{_ in self.write()}

        // Below code is only for Android
	    self.page!.onExit.append(SCDWidgetsExitEventHandler{_ in
	    	self.nfcManager?.disableForegroundDispatch()
        })
  	}
  	
    // write func
  	func write() {

  		// prepare the NFCURIRecord from the URL
        var uriRecord: NFCURIRecord?
        if let url = URL(string: urlTextBox.text) {
            uriRecord = NFCURIRecord(url: url)
        }
        
        // prepare the NFCTextRecord from the String and Locale
        let textRecord = NFCTextRecord(string: descriptionTextBox.text, locale: Locale(identifier: "en"))

        // initialize the NFCMessage with NFCURIRecord and NFCTextRecord
        let nfcMessage = NFCMessage(uriRecord: uriRecord, textRecord: textRecord)
        
        // initialize the NFCMessage
        nfcManager = NFCManager(alertMessage: "Hold your iPhone near an NFC tag.")

        // write NFC Tag
        nfcManager?.writeTag(nfcMessage)
    }	
}
