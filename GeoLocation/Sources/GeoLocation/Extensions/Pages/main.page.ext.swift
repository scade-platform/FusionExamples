import ScadeKit

extension MainPageAdapter {
  var startButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("startButton") as! SCDWidgetsButton
  }

  var current_city: SCDWidgetsLabel {
    return self.page?.getWidgetByName("current_city") as! SCDWidgetsLabel
  }

  var label1: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label1") as! SCDWidgetsLabel
  }

  var label: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label") as! SCDWidgetsLabel
  }

  var BearingText: SCDWidgetsLabel {
    return self.page?.getWidgetByName("BearingText") as! SCDWidgetsLabel
  }

  var distanceText: SCDWidgetsLabel {
    return self.page?.getWidgetByName("distanceText") as! SCDWidgetsLabel
  }

  var bearingLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("bearingLabel") as! SCDWidgetsLabel
  }

  var list: SCDWidgetsList {
    return self.page?.getWidgetByName("list") as! SCDWidgetsList
  }

  var grid: SCDWidgetsGridView {
    return self.page?.getWidgetByName("grid") as! SCDWidgetsGridView
  }

  var choose_city: SCDWidgetsButton {
    return self.page?.getWidgetByName("choose_city") as! SCDWidgetsButton
  }

  var arrow_button: SCDWidgetsButton {
    return self.page?.getWidgetByName("arrow_button") as! SCDWidgetsButton
  }

  var latLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("latLabel") as! SCDWidgetsLabel
  }

  var lngLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("lngLabel") as! SCDWidgetsLabel
  }

  var distanceLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("distanceLabel") as! SCDWidgetsLabel
  }
}