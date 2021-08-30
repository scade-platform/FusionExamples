import ScadeKit
import FusionBluetooth
import Foundation

class Device: EObject {
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

	let bluetoothManager = BluetoothManager()

	private var deviceArray: [Device] = []
	private var selectedDevice: Device? = nil
   
    override func load(_ path: String) {
        super.load(path)
        
        discoverButton.onClick.append(SCDWidgetsEventHandler{ _ in self.discoverDevicesOrStop()})
        connectButton.onClick.append(SCDWidgetsEventHandler{ _ in self.connectDisconect()})
        sendMessageButton.onClick.append(SCDWidgetsEventHandler{ _ in self.sendMessage()})
        
        self.devicesList.elementProvider = SCDWidgetsElementProvider { (device: Device, template) in
            var nameText = device.name
            if nameText == nil || nameText == "" {
                nameText = device.uuid
            }
        
          (template.getWidgetByName("nameLabel") as! SCDWidgetsLabel).text = nameText ?? ""
        }
        
        self.devicesList.onItemSelected.append(
            SCDWidgetsItemSelectedEventHandler { ev in
                if let device = ev!.item as? Device {
                    self.selectedDeviceNameLabel.text = "Name: \(device.name ?? "")"
                    self.selectedDeviceUuidLabel.text = "UUID: \(device.uuid)"
                    self.selectedDeviceStateLabel.text = "State: \(device.isConnected ? "Connected" : "Disconnected")"
                    if device.isConnected {
                        self.connectButton.text = "Disconnect"
                    } else {
                        self.connectButton.text = "Connect"
                    }
                    self.selectedDevice = device
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
    		let device = Device(name: peripheral.name, uuid: peripheral.uuid, isConnected: peripheral.isConnected)
            if self.deviceArray.first(where: {$0.uuid == device.uuid}) == nil {
				self.deviceArray.append(device)
				self.devicesList.items = self.deviceArray
            }
        }
	}
	
	func connectDisconect() {
        if let selectedDevice = self.selectedDevice {
            if selectedDevice.isConnected {
                bluetoothManager.disconnectDevice(uuid: selectedDevice.uuid) { peripheral, error in
                    guard let peripheral = peripheral, let device = self.deviceArray.first(where: { peripheral.uuid == $0.uuid }) else { return }
                    device.isConnected = false                    
                    self.selectedDeviceStateLabel.text = device.isConnected ? "Connected" : "Disconnected"
                    self.connectButton.text = "Connect"
                    self.selectedDevice = device
                    
                    self.sendMessageTextField.text = ""
                    self.receivedMessageTextField.text = ""
                }
            } else {
                bluetoothManager.connectDevice(uuid: selectedDevice.uuid) { peripheral, error in
                    guard let peripheral = peripheral, let device = self.deviceArray.first(where: { peripheral.uuid == $0.uuid }) else { return }
                    device.isConnected = true
                    self.selectedDeviceStateLabel.text = device.isConnected ? "Connected" : "Disconnected"
                    self.connectButton.text = "Disconnect"
                    self.selectedDevice = device
                    
                    self.bluetoothManager.readCharacteristic(uuid: device.uuid) { data in
                        self.sendMessageTextField.text = self.bodyLocation(from: data)
                    }
                    
                    self.bluetoothManager.notifyCharacteristic(uuid: device.uuid) { data in
                        self.receivedMessageTextField.text = String(self.heartRate(from: data))
                    }
                }
            }
        }
	}
	
	func sendMessage() {
        if let data = sendMessageTextField.text.data(using: .utf8), let uuid = selectedDevice?.uuid {
            bluetoothManager.writeCharacteristic(uuid: uuid, data: data)
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
