import ScadeKit
import FusionNFC
  
class ReaderPageAdapter: SCDLatticePageAdapter {
    var nfcManager: NFCManager?  
  	// page adapter initialization
  	override func load(_ path: String) {
    	super.load(path)
		nfcManager = NFCManager(alertMessage: "Hold your iPhone near an NFC tag.")    	
        self.readButton.onClick{_ in self.read()}
	    self.page!.onExit.append(SCDWidgetsExitEventHandler{_ in
	    	self.nfcManager?.disableForegroundDispatch()
        })        
  	}
  	
  	func read() {
  		urlLabel.text = "pavlo start read func"

        nfcManager?.readTag { message in
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
