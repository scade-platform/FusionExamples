import ScadeKit
import FusionBluetooth
import Foundation

class BTDevice: EObject {
    let name: String?
    let uuid: String
    var isConnected: Bool
    
    init(name: String?, uuid: String, isConnected: Bool) {
        self.name = name
        self.uuid = uuid
        self.isConnected = isConnected
    }
}

class MainPageAdapter: SCDLatticePageAdapter {

	let bluetoothManager = BluetoothManager.shared

	private var deviceArray: [Device] = []
	private var btDeviceArray: [BTDevice] = []
	private var selectedDevice: Device? = nil
   
    override func load(_ path: String) {
        super.load(path)
        
        discoverButton.onClick.append(SCDWidgetsEventHandler{ _ in self.discoverDevicesOrStop()})
        connectButton.onClick.append(SCDWidgetsEventHandler{ _ in self.connectDisconect()})
        sendMessageButton.onClick.append(SCDWidgetsEventHandler{ _ in self.sendMessage()})
        
        self.devicesList.elementProvider = SCDWidgetsElementProvider { (device: BTDevice, template) in
            var nameText = device.name
            if nameText == nil || nameText == "" {
                nameText = device.uuid
            }
        
          (template.getWidgetByName("nameLabel") as! SCDWidgetsLabel).text = nameText ?? ""
        }
        
        self.devicesList.onItemSelected.append(
            SCDWidgetsItemSelectedEventHandler { ev in
                if let btDevice = ev!.item as? BTDevice {
                    self.selectedDeviceNameLabel.text = "Name: \(btDevice.name ?? "")"
                    self.selectedDeviceUuidLabel.text = "UUID: \(btDevice.uuid)"
                    self.selectedDeviceStateLabel.text = "State: \(btDevice.isConnected ? "Connected" : "Disconnected")"
                    if btDevice.isConnected {
                        self.connectButton.text = "Disconnect"
                    } else {
                        self.connectButton.text = "Connect"
                    }
                    if let device = self.deviceArray.first(where: {$0.uuid == btDevice.uuid}) {
                    	self.selectedDevice = device	
                    }                    
                }
             }
          )
    }

  
    func discoverDevicesOrStop() {
    	discoverButton.text = "Stop"

        bluetoothManager.startDiscovering() { peripheral, error in
            guard let peripheral = peripheral else {
                self.bluetoothManager.stopDiscovering()
                self.discoverButton.text = "Discover"
                if let error = error {
                    print("error: \(error.description())")
                }
                return
            }
    		let btDevice = BTDevice(name: peripheral.name, uuid: peripheral.uuid, isConnected: peripheral.isConnected)
            if self.deviceArray.first(where: {$0.uuid == peripheral.uuid}) == nil {
				self.deviceArray.append(peripheral)
				self.btDeviceArray.append(btDevice)
				self.devicesList.items = self.btDeviceArray
            }
        }
	}
	
	func connectDisconect() {
        if let selectedDevice = self.selectedDevice {
            if selectedDevice.isConnected {
                selectedDevice.disconnect { success, error in
                    guard success else { return }
//                    device.isConnected = false
                    self.selectedDeviceStateLabel.text = "Connected"
                    self.connectButton.text = "Connect"
//                    self.selectedDevice = device
                    
                    self.sendMessageTextField.text = ""
                    self.receivedMessageTextField.text = ""
                }
            } else {
                selectedDevice.connect { success, error in
                    guard success else { return }
//                    device.isConnected = true
                    self.selectedDeviceStateLabel.text = "Disconnected"
                    self.connectButton.text = "Disconnect"
//                    self.selectedDevice = device
                    
                    selectedDevice.read { data in
                        self.sendMessageTextField.text = self.bodyLocation(from: data)
                    }
                    
                    selectedDevice.notify { data in
                        self.receivedMessageTextField.text = String(self.heartRate(from: data))
                    }
                }
            }
        }
	}
	
	func sendMessage() {
        if let data = sendMessageTextField.text.data(using: .utf8), let selectedDevice = selectedDevice {
            selectedDevice.write(data: data)
        }		
	}
	
    private func bodyLocation(from data: Data?) -> String {
      guard let data = data, let byte = data.first else { return "Error" }

      switch byte {
      case 0: return "Other"
      case 1: return "Chest"
      case 2: return "Wrist"
      case 3: return "Finger"
      case 4: return "Hand"
      case 5: return "Ear Lobe"
      case 6: return "Foot"
      default:
        return "Reserved for future use"
      }
    }
    
    private func heartRate(from data: Data?) -> Int {
      guard let characteristicData = data else { return -1 }
      let byteArray = [UInt8](characteristicData)
      
      let firstBitValue = byteArray[0] & 0x01
      if firstBitValue == 0 {
        // Heart Rate Value Format is in the 2nd byte
        return Int(byteArray[1])
      } else {
        // Heart Rate Value Format is in the 2nd and 3rd bytes
        return (Int(byteArray[1]) << 8) + Int(byteArray[2])
      }
    }	
}
