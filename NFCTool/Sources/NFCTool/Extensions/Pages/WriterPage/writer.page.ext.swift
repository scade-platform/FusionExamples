import ScadeKit

extension WriterPageAdapter {
  var listView1: SCDWidgetsListView {
    return self.page?.getWidgetByName("listView1") as! SCDWidgetsListView
  }

  var inputUrlLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("inputUrlLabel") as! SCDWidgetsLabel
  }

  var urlTextBox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("urlTextBox") as! SCDWidgetsTextbox
  }

  var inputDescriptionLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("inputDescriptionLabel") as! SCDWidgetsLabel
  }

  var descriptionTextBox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("descriptionTextBox") as! SCDWidgetsTextbox
  }

  var button1: SCDWidgetsButton {
    return self.page?.getWidgetByName("button1") as! SCDWidgetsButton
  }
}