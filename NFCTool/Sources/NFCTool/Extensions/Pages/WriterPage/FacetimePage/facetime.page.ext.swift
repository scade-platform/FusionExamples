import ScadeKit

extension FacetimePageAdapter {
  var write_nfc_btn: SCDWidgetsButton {
    return self.page?.getWidgetByName("write_nfc_btn") as! SCDWidgetsButton
  }

  var desc_textbox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("desc_textbox") as! SCDWidgetsTextbox
  }

  var label: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label") as! SCDWidgetsLabel
  }

  var image: SCDWidgetsImage {
    return self.page?.getWidgetByName("image") as! SCDWidgetsImage
  }

  var facetime_textbox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("facetime_textbox") as! SCDWidgetsTextbox
  }
}