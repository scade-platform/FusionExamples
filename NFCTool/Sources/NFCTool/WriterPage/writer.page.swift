import Foundation
import ScadeKit
import FusionNFC
  
class WriterPageAdapter: SCDLatticePageAdapter {
    var nfcManager: NFCManager?  
  	// page adapter initialization
  	override func load(_ path: String) {
    	super.load(path)
    	nfcManager = NFCManager(alertMessage: "Hold your iPhone near an NFC tag.")
    	self.writeButton.onClick{_ in self.write()}
  		self.page!.onExit.append(SCDWidgetsExitEventHandler{_ in
	    	self.nfcManager?.disableForegroundDispatch()
        })   
  	}
  	
  	func write() {
  		urlTextBox.text = "pavlo start write func"
        var uriRecord: NFCURIRecord?
    }  	
}