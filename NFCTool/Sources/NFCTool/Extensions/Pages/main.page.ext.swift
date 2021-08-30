import ScadeKit

extension MainPageAdapter {
  var pageContainer1: SCDLatticePageContainer {
    return self.page?.getWidgetByName("pageContainer1") as! SCDLatticePageContainer
  }

  var toolbar: SCDWidgetsToolBar {
    return self.page?.getWidgetByName("toolbar") as! SCDWidgetsToolBar
  }

  var readerButton: SCDWidgetsListView {
    return self.page?.getWidgetByName("readerButton") as! SCDWidgetsListView
  }

  var image: SCDWidgetsImage {
    return self.page?.getWidgetByName("image") as! SCDWidgetsImage
  }

  var button1: SCDWidgetsButton {
    return self.page?.getWidgetByName("button1") as! SCDWidgetsButton
  }

  var writerButton: SCDWidgetsListView {
    return self.page?.getWidgetByName("writerButton") as! SCDWidgetsListView
  }

  var image1: SCDWidgetsImage {
    return self.page?.getWidgetByName("image1") as! SCDWidgetsImage
  }

  var button: SCDWidgetsButton {
    return self.page?.getWidgetByName("button") as! SCDWidgetsButton
  }
}