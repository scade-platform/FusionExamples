import ScadeKit
import FusionNFC
  
class ReaderPageAdapter: SCDLatticePageAdapter {
    var nfcManager: NFCManager?  
  	// page adapter initialization
  	override func load(_ path: String) {
    	super.load(path)
    	// initialize the NFCManager
		nfcManager = NFCManager(alertMessage: "Hold your iPhone near an NFC tag.")

		// connect the button action to read func
        self.readButton.onClick{_ in self.read()}

        // Below code is only for Android
	    self.page!.onExit.append(SCDWidgetsExitEventHandler{_ in
	    	self.nfcManager?.disableForegroundDispatch()
        })     
  	}
  	
  	// read func
  	func read() {
  		// read NFC Tag
        nfcManager?.readTag { message in

        	// get url and text from NFCMessage
        	guard let message = message else { return }
        	if let uriRecord = message.uriRecord {
        		self.urlLabel.text = "URL: \(uriRecord.url.absoluteString)"
        	}
          	
          	if let textRecord = message.textRecord {
          		self.descriptionLabel.text = "Description: \(textRecord.string)"	
          	}			
        }
    }
}
