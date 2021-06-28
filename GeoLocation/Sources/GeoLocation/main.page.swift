import FusionLocation
import ScadeKit

enum DestCity: String {
  case newyork = "New York"
  case london = "London"
  case moscow = "Moscow"

  func getLocation() -> Location {
    switch self {
    case .newyork:
      return Location(latitude: 40.730610, longitude: -73.935242)
    case .london:
      return Location(latitude: 51.509865, longitude: -0.118092)
    case .moscow:
      return Location(latitude: 55.751244, longitude: 37.618423)
    }
  }
}

class MainPageAdapter: SCDLatticePageAdapter {
  // page adapter initialization
  var destCity: DestCity = .newyork
  var currentLocation: Location?

  let locationManager = LocationManager(usage: .always)

  let url =
    "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=c5880f1e980df499f89bd477ff0a5b27"

  func getCity(lat: Double, lon: Double) {
    let urlString = "\(url)&lon=\(lon)&lat=\(lat)"
    performRequest(with: urlString)
  }

  private func performRequest(with urlString: String) {
    guard let url = URL(string: urlString) else {
      return
    }

    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in

      if let saveData = data {
        self.parseJSON(data: saveData)
      }
    }

    task.resume()
  }

  func parseJSON(data: Data) {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(CityName.self, from: data)
      let name = decodedData.name
      DispatchQueue.main.async {
        self.current_city.text = name
      }

    } catch {
    }
  }

  override func load(_ path: String) {
    super.load(path)

    startButton.onClick.append(SCDWidgetsEventHandler { _ in self.startUpdatingLocation() })
    //stopButton.onClick.append(SCDWidgetsEventHandler{ _ in self.stopUpdatingLocation()})
    grid.onClick.append(
      SCDWidgetsEventHandler { _ in
        if self.list.visible == true {
          self.list.visible = false
        } else {
          self.list.visible = true
        }
      })

    list.elementProvider = SCDWidgetsElementProvider { (labelText: String, listElement) in
      guard let label = listElement.getWidgetByName("cityName") as? SCDWidgetsLabel else { return }

      label.text = labelText
    }

    list.items = ["Moscow", "New York", "London"]

    list.onItemSelected.append(
      SCDWidgetsItemSelectedEventHandler { event in
        self.list.visible = false
        self.choose_city.text = event!.item as! String
        self.changeDestCity(DestCity(rawValue: event!.item as! String)!)
      })

    locationManager.requestAuthorization()
  }

  func changeDestCity(_ destCity: DestCity) {
    startUpdatingLocation()
    self.destCity = destCity
    updateLabels()
  }

  func startUpdatingLocation() {
    locationManager.startUpdatingLocation { location in
      self.getCity(lat: location!.coordinate.latitude, lon: location!.coordinate.longitude)
      guard let location = location else { return }
      self.currentLocation = location
      self.updateLabels()
    }
  }

  //	func stopUpdatingLocation() {
  //		locationManager.stopUpdatingLocation()
  //		startButton.text = "Start tracking"
  //	}

  func updateLabels() {
    guard let location = self.currentLocation else { return }
    lngLabel.text = "\(location.coordinate.longitude)"
    latLabel.text = "\(location.coordinate.latitude)"
    startButton.text = "Update location"
    self.choose_city.text = destCity.rawValue
    let distance = String(
      format: "%.01f",
      self.locationManager.distanceBetween(from: destCity.getLocation(), to: location) / 1000)
    let bearing = String(
      format: "%.02f",
      self.locationManager.bearingBetween(from: destCity.getLocation(), to: location))
    distanceLabel.text = "\(distance)"
    bearingLabel.text = "\(bearing)"
  }
}
