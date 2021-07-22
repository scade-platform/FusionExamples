import ScadeKit

extension MainPageAdapter {
  var devicesList: SCDWidgetsList {
    return self.page?.getWidgetByName("devicesList") as! SCDWidgetsList
  }

  var rowView1: SCDWidgetsRowView {
    return self.page?.getWidgetByName("rowView1") as! SCDWidgetsRowView
  }

  var deviceLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("deviceLabel") as! SCDWidgetsLabel
  }

  var discoverButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("discoverButton") as! SCDWidgetsButton
  }

  var listView1: SCDWidgetsListView {
    return self.page?.getWidgetByName("listView1") as! SCDWidgetsListView
  }

  var label1: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label1") as! SCDWidgetsLabel
  }

  var selectedDeviceNameLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("selectedDeviceNameLabel") as! SCDWidgetsLabel
  }

  var selectedDeviceUuidLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("selectedDeviceUuidLabel") as! SCDWidgetsLabel
  }

  var selectedDeviceStateLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("selectedDeviceStateLabel") as! SCDWidgetsLabel
  }

  var connectButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("connectButton") as! SCDWidgetsButton
  }

  var rowView2: SCDWidgetsRowView {
    return self.page?.getWidgetByName("rowView2") as! SCDWidgetsRowView
  }

  var statusLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("statusLabel") as! SCDWidgetsLabel
  }
}