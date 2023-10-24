import ScadeKit

extension TimerPagePageAdapter {
  var label: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label") as! SCDWidgetsLabel
  }

  var titleTextfield: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("titleTextfield") as! SCDWidgetsTextbox
  }

  var label1: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label1") as! SCDWidgetsLabel
  }

  var bodyTextfield: SCDWidgetsTextbox {
    return self.page?.getWidgetByName("bodyTextfield") as! SCDWidgetsTextbox
  }

  var sendButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("sendButton") as! SCDWidgetsButton
  }
}