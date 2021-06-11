import ScadeKit
import FusionLocation

enum DestCity: String {
	case newyork = "New York"
	case london = "London"
	case moscow = "Moscow"
	
	func getLocation() -> Location {
		switch self {
		case .newyork:
			return Location(latitude: 40.730610,longitude: -73.935242)
		case .london:
			return Location(latitude: 51.509865,longitude: -0.118092)
		case .moscow:
			return Location(latitude: 55.751244,longitude: 37.618423)
		}
	}
}

class MainPageAdapter: SCDLatticePageAdapter {  
  	// page adapter initialization
  	var destCity: DestCity = .newyork
  	var currentLocation: Location?
  	
  	let locationManager = LocationManager(usage: .always)
  	
  	override func load(_ path: String) {
    	super.load(path)
    	
    	startButton.onClick.append(SCDWidgetsEventHandler{ _ in self.startUpdatingLocation()})
    	stopButton.onClick.append(SCDWidgetsEventHandler{ _ in self.stopUpdatingLocation()})
		newyorkButton.onClick.append(SCDWidgetsEventHandler{ _ in self.changeDestCity(.newyork)})
    	londonButton.onClick.append(SCDWidgetsEventHandler{_ in self.changeDestCity(. london)})
    	moscowButton.onClick.append(SCDWidgetsEventHandler{_ in self.changeDestCity(. moscow)})
    	
    	locationManager.requestAuthorization()
  	}
  
	func changeDestCity(_ destCity: DestCity) {
	    startUpdatingLocation()
		self.destCity = destCity
		updateLabels()
	}

	func startUpdatingLocation() {
		locationManager.startUpdatingLocation { location in
        	guard let location = location else { return }
        	self.currentLocation = location
        	self.updateLabels()
		}        
	}
	
	func stopUpdatingLocation() {
		locationManager.stopUpdatingLocation()
	}
	
	func updateLabels() {
		guard let location = self.currentLocation else { return }
		lngLabel.text = "Longitude: \(location.coordinate.longitude)"
		latLabel.text = "Latitude: \(location.coordinate.latitude)"
		let distance = String(format: "%.01f", self.locationManager.distanceBetween(from: destCity.getLocation(), to: location) / 1000)
		let bearing = String(format: "%.02f", self.locationManager.bearingBetween(from: destCity.getLocation(), to: location))
		distanceLabel.text = "Distance from \(destCity.rawValue)(kilometers): \(distance)"
		bearingLabel.text = "Bearing from \(destCity.rawValue)(degree): \(bearing)"
	}
}
