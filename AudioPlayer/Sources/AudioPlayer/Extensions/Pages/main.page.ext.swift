import ScadeKit

extension MainPageAdapter {
  var rowView1: SCDWidgetsRowView {
    return self.page?.getWidgetByName("rowView1") as! SCDWidgetsRowView
  }

  var image2: SCDWidgetsImage {
    return self.page?.getWidgetByName("image2") as! SCDWidgetsImage
  }

  var image3: SCDWidgetsImage {
    return self.page?.getWidgetByName("image3") as! SCDWidgetsImage
  }

  var volumeSlide: SCDWidgetsSliderLine {
    return self.page?.getWidgetByName("volumeSlide") as! SCDWidgetsSliderLine
  }

  var playStopButton: SCDWidgetsImage {
    return self.page?.getWidgetByName("playStopButton") as! SCDWidgetsImage
  }

  var rowView2: SCDWidgetsRowView {
    return self.page?.getWidgetByName("rowView2") as! SCDWidgetsRowView
  }

  var playPositionLabel: SCDWidgetsLabel {
    return self.page?.getWidgetByName("playPositionLabel") as! SCDWidgetsLabel
  }

  var positionSlide: SCDWidgetsSliderLine {
    return self.page?.getWidgetByName("positionSlide") as! SCDWidgetsSliderLine
  }
}