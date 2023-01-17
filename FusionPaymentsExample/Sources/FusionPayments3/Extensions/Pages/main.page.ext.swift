import ScadeKit

extension MainPageAdapter {
  var button: SCDWidgetsButton {
    return self.page?.getWidgetByName("button") as! SCDWidgetsButton
  }
}