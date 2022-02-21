import ScadeKit

extension MessagePageAdapter {
  var image: SCDWidgetsImage {
    return self.page?.getWidgetByName("image") as! SCDWidgetsImage
  }

  var write_nfc_btn: SCDWidgetsButton {
    return self.page?.getWidgetByName("write_nfc_btn") as! SCDWidgetsButton
  }

  var desc_textbox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("desc_textbox") as! SCDWidgetsTextbox
  }

  var label: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label") as! SCDWidgetsLabel
  }

  var sms_phone_textbox: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("sms_phone_textbox") as! SCDWidgetsTextbox
  }
}