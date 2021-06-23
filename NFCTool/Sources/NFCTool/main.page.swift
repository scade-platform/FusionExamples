import ScadeKit
  
class MainPageAdapter: SCDLatticePageAdapter {
  
	let reader : ReaderPageAdapter = ReaderPageAdapter()
	let writer : WriterPageAdapter = WriterPageAdapter()
	var pageContainer : SCDLatticePageContainer?
	
  	// page adapter initialization
  	override func load(_ path: String) {
    	super.load(path)
    	
    	self.reader.load("reader.page")
        self.writer.load("writer.page")
        
        self.readerButton.onClick{_ in self.showPage(self.reader)}
        self.writerButton.onClick{_ in self.showPage(self.writer)}
        
		// Now,we get a reference to the page container
		self.pageContainer = self.page!.getWidgetByName("pageContainer1") as? SCDLatticePageContainer 
		
		// Finally, we use the page container to show page1
		self.reader.show(view: self.pageContainer)        
	}
	
	func showPage(_ page:SCDLatticePageAdapter) {
        page.show(view: self.pageContainer)
    }
}
