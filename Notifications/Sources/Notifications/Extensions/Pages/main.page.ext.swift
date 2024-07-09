import ScadeKit

extension MainPageAdapter {
  var pageContainer: SCDLatticePageContainer {
    return self.page?.getWidgetByName("pageContainer") as! SCDLatticePageContainer
  }

  var toolBar: SCDWidgetsToolBar {
    return self.page?.getWidgetByName("toolBar") as! SCDWidgetsToolBar
  }

  var timerButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("timerButton") as! SCDWidgetsButton
  }

  var pushButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("pushButton") as! SCDWidgetsButton
  }
}