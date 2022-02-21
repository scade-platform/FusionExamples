import ScadeKit

extension ReaderPageAdapter {
  var category_list: SCDWidgetsList {
    return self.page?.getWidgetByName("category_list") as! SCDWidgetsList
  }

  var read_nfc_button: SCDWidgetsButton {
    return self.page?.getWidgetByName("read_nfc_button") as! SCDWidgetsButton
  }
}