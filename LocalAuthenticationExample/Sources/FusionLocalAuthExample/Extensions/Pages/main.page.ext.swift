import ScadeKit

extension MainPageAdapter {
  var label1: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label1") as! SCDWidgetsLabel
  }

  var label: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label") as! SCDWidgetsLabel
  }
}