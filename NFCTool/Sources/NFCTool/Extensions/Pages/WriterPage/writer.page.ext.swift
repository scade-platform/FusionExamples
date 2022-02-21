import ScadeKit

extension WriterPageAdapter {
  var category_list: SCDWidgetsList {
    return self.page?.getWidgetByName("category_list") as! SCDWidgetsList
  }
}