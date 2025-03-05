import ScadeKit
  
class MainPageAdapter: SCDLatticePageAdapter {
  
	let timer : TimerPagePageAdapter = TimerPagePageAdapter()
	let push : PushPagePageAdapter = PushPagePageAdapter()
	
  	// page adapter initialization
  	override func load(_ path: String) {
    	super.load(path)
    	
    	self.timer.load("TimerPage.page")
        self.push.load("PushPage.page")
        
        self.timerButton.onClick{_ in self.showPage(self.timer)}
        self.pushButton.onClick{_ in self.showPage(self.push)}        
	
		// Finally, we use the page container to show page1
		self.timer.show(view: self.pageContainer)        
	}
	
	func showPage(_ page:SCDLatticePageAdapter) {
        page.show(view: self.pageContainer)
    }
}
