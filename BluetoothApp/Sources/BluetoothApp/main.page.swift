import ScadeKit
import FusionBluetooth

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
      
      self.bluetoothManager.requestAuthorization()
      
      self.checkState()
      
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
    
    func checkState() {
    	bluetoothManager.checkState() { enabled in 
    		self.statusLabel.text = enabled ? "Turned on" : "Turned Off"
    	}
    }
  
    func discoverDevicesOrStop() {
        if !bluetoothManager.isScanning() {
            bluetoothManager.discoverDevice() { peripheral in
                guard let peripheral = peripheral else { return }
                let device = Device(name: peripheral.name, uuid: peripheral.uuid, isConnected: peripheral.isConnected)
                if self.deviceArray.first(where: {$0.uuid == device.uuid}) == nil {
                     self.deviceArray.append(device)
                     self.devicesList.items = self.deviceArray
                }
            }
            
            discoverButton.text = "Stop"
        } else {
            bluetoothManager.stopDiscovering() 
            discoverButton.text = "Discover"
        }
	}
	
	func connectDisconect() {
		if let selectedDevice = self.selectedDevice {
			if selectedDevice.isConnected {
				bluetoothManager.disconnectDevice(uuid: selectedDevice.uuid) { peripheral in
					guard let peripheral = peripheral else { return }
			  		if let device = self.deviceArray.first(where: { peripheral.uuid == $0.uuid }) {
			  			device.isConnected = peripheral.isConnected
						self.selectedDeviceStateLabel.text = peripheral.isConnected ? "Connected" : "Disconnected"
						self.connectButton.text = "Connect"
						self.selectedDevice = device
        			}
				}
			} else {
				bluetoothManager.connectDevice(uuid: selectedDevice.uuid) { peripheral in
					guard let peripheral = peripheral else { return }
			  		if let device = self.deviceArray.first(where: { peripheral.uuid == $0.uuid }) {
			  			device.isConnected = peripheral.isConnected
						self.selectedDeviceStateLabel.text = peripheral.isConnected ? "Connected" : "Disconnected"
						self.connectButton.text = "Disconnect"
						self.selectedDevice = device
        			}
				}
			}
        }
	}
}
