import ScadeKit

extension ReaderPageAdapter {
  var listView1: SCDWidgetsListView {
    return self.page?.getWidgetByName("listView1") as! SCDWidgetsListView
  }

  var urlLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("urlLabel") as! SCDWidgetsLabel
  }

  var descriptionLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("descriptionLabel") as! SCDWidgetsLabel
  }

  var readButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("readButton") as! SCDWidgetsButton
  }
}