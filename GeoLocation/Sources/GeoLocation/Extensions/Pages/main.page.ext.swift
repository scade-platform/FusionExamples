import ScadeKit

extension MainPageAdapter {
  var listView1: SCDWidgetsListView {
    return self.page?.getWidgetByName("listView1") as! SCDWidgetsListView
  }

  var label: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label") as! SCDWidgetsLabel
  }

  var lngLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("lngLabel") as! SCDWidgetsLabel
  }

  var latLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("latLabel") as! SCDWidgetsLabel
  }

  var gridView1: SCDWidgetsGridView {
    return self.page?.getWidgetByName("gridView1") as! SCDWidgetsGridView
  }

  var label1: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label1") as! SCDWidgetsLabel
  }

  var newyorkButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("newyorkButton") as! SCDWidgetsButton
  }

  var londonButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("londonButton") as! SCDWidgetsButton
  }

  var moscowButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("moscowButton") as! SCDWidgetsButton
  }

  var listView2: SCDWidgetsListView {
    return self.page?.getWidgetByName("listView2") as! SCDWidgetsListView
  }

  var distanceLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("distanceLabel") as! SCDWidgetsLabel
  }

  var bearingLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("bearingLabel") as! SCDWidgetsLabel
  }

  var gridView2: SCDWidgetsGridView {
    return self.page?.getWidgetByName("gridView2") as! SCDWidgetsGridView
  }

  var startButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("startButton") as! SCDWidgetsButton
  }

  var stopButton: SCDWidgetsButton {
    return self.page?.getWidgetByName("stopButton") as! SCDWidgetsButton
  }
}