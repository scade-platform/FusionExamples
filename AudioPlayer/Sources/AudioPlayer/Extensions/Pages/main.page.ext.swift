import ScadeKit

extension MainPageAdapter {
  var button1: SCDWidgetsButton {
    return self.page?.getWidgetByName("button1") as! SCDWidgetsButton
  }
}