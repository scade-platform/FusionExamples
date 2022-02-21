import ScadeKit

extension PhonenumberPageAdapter {
  var phone_label: SCDWidgetsLabel {
    return self.page?.getWidgetByName("phone_label") as! SCDWidgetsLabel
  }

  var image_phone: SCDWidgetsImage {
    return self.page?.getWidgetByName("image_phone") as! SCDWidgetsImage
  }

  var phone_textbox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("phone_textbox") as! SCDWidgetsTextbox
  }

  var desc_textbox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("desc_textbox") as! SCDWidgetsTextbox
  }

  var write_nfc_btn: SCDWidgetsButton {
    return self.page?.getWidgetByName("write_nfc_btn") as! SCDWidgetsButton
  }
}