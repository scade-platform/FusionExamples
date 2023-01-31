import ScadeKit

extension MainPageAdapter {
  var button: SCDWidgetsButton {
    return self.page?.getWidgetByName("button") as! SCDWidgetsButton
  }

  var container: SCDWidgetsContainer {
    return self.page?.getWidgetByName("container") as! SCDWidgetsContainer
  }

  var label: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label") as! SCDWidgetsLabel
  }
}