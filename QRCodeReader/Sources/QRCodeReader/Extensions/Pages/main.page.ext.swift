import ScadeKit

extension MainPageAdapter {
  var videoCaptureView: SCDWidgetsVideoCaptureView {
    return self.page?.getWidgetByName("videoCaptureView") as! SCDWidgetsVideoCaptureView
  }

  var button: SCDWidgetsButton {
    return self.page?.getWidgetByName("button") as! SCDWidgetsButton
  }

  var button1: SCDWidgetsButton {
    return self.page?.getWidgetByName("button1") as! SCDWidgetsButton
  }
}