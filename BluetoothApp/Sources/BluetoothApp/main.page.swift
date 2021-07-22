import ScadeKit
import FusionBluetooth

class Device: EObject {
    let name: String?
    let uuid: String
    var state: PeripheralState
    
    init(name: String?, uuid: String, state: PeripheralState) {
        self.name = name
        self.uuid = uuid
        self.state = state
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
      
      self.checkState()
      
      self.devicesList.elementProvider = SCDWidgetsElementProvider { (device: Device, template) in
        (template.getWidgetByName("nameLabel") as! SCDWidgetsLabel).text = device.name ?? device.uuid
      }
      
      self.devicesList.onItemSelected.append(
          SCDWidgetsItemSelectedEventHandler { ev in
              if let device = ev!.item as? Device {
                  self.selectedDeviceNameLabel.text = "Name: \(device.name ?? "")"
                  self.selectedDeviceUuidLabel.text = "UUID: \(device.uuid)"
                  self.selectedDeviceStateLabel.text = "State: \(device.state.rawValue)"
                  if device.state == .connected || device.state == .connecting {
	                  self.connectButton.text = "Disconnect"
                  } else {
	                  self.connectButton.text = "Connect"               	
                  }
                  self.selectedDevice = device
              }
           }
        )
    }
    
    func checkState() {
    	bluetoothManager.checkState() { state in 
    		self.statusLabel.text = state.rawValue
    	}
    }
  
    func discoverDevicesOrStop() {
        if !bluetoothManager.isScanning() {
            bluetoothManager.discoverDevice() { peripheral in
                guard let peripheral = peripheral else { return }
                self.deviceArray.append(Device(name: peripheral.name, uuid: peripheral.uuid, state: peripheral.state))
                self.devicesList.items = self.deviceArray
            }
            
            discoverButton.text = "Stop"
        } else {
            bluetoothManager.stopDiscovering() 
            discoverButton.text = "Discover"
        }
	}
	
	func connectDisconect() {
		if let selectedDevice = self.selectedDevice {
			if selectedDevice.state == .connected || selectedDevice.state == .connecting {
				bluetoothManager.disconnectDevice(uuid: selectedDevice.uuid) { peripheral in
					guard let peripheral = peripheral else { return }
			  		if let device = self.deviceArray.first(where: { peripheral.uuid == $0.uuid }) {
			  			device.state = peripheral.state
						self.selectedDeviceStateLabel.text = peripheral.state.rawValue
						self.connectButton.text = "Connect"
						self.selectedDevice = device
        			}
				}
			} else {
				bluetoothManager.connectDevice(uuid: selectedDevice.uuid) { peripheral in
					guard let peripheral = peripheral else { return }
			  		if let device = self.deviceArray.first(where: { peripheral.uuid == $0.uuid }) {
			  			device.state = peripheral.state
						self.selectedDeviceStateLabel.text = peripheral.state.rawValue
						self.connectButton.text = "Disconnect"
						self.selectedDevice = device
        			}
				}
			}
        }
	}
}
