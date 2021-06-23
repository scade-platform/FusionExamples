import ScadeKit
import FusionNFC
  
class ReaderPageAdapter: SCDLatticePageAdapter {
    var nfcUtility: NFCUtility?  
  	// page adapter initialization
  	override func load(_ path: String) {
    	super.load(path)
        self.readButton.onClick{_ in self.read()}    	
  	}
  	
  	func read() {
  		print("pavlo start read func")
		nfcUtility = NFCUtility(alertMessage: "Hold your iPhone near an NFC tag.")        nfcUtility?.readTag { message in            print("url = \(message?.uriRecord?.url)")        }
    }
}
