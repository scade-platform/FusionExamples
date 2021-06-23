import ScadeKit

extension MainPageAdapter {
  var pageContainer1: SCDLatticePageContainer {
    return self.page?.getWidgetByName("pageContainer1") as! SCDLatticePageContainer
  }

  var rowView1: SCDWidgetsRowView {
    return self.page?.getWidgetByName("rowView1") as! SCDWidgetsRowView
  }

  var readerButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("readerButton") as! SCDWidgetsButton
  }

  var writerButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("writerButton") as! SCDWidgetsButton
  }
}