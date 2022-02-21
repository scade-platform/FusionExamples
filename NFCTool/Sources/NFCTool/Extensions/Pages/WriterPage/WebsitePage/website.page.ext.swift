import ScadeKit

extension WebsitePageAdapter {
  var image: SCDWidgetsImage {
    return self.page?.getWidgetByName("image") as! SCDWidgetsImage
  }

  var label: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label") as! SCDWidgetsLabel
  }

  var desc_textbox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("desc_textbox") as! SCDWidgetsTextbox
  }

  var write_nfc_btn: SCDWidgetsButton {
    return self.page?.getWidgetByName("write_nfc_btn") as! SCDWidgetsButton
  }

  var website_textbox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("website_textbox") as! SCDWidgetsTextbox
  }
}