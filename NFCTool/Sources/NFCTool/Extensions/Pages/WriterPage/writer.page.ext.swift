import ScadeKit

extension WriterPageAdapter {
  var listView1: SCDWidgetsListView {
    return self.page?.getWidgetByName("listView1") as! SCDWidgetsListView
  }

  var writeButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("writeButton") as! SCDWidgetsButton
  }

  var urlTextBox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("urlTextBox") as! SCDWidgetsTextbox
  }

  var descriptionTextBox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("descriptionTextBox") as! SCDWidgetsTextbox
  }
}