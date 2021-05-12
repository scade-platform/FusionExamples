import Foundation
import ScadeKit
import ScadeExtensions
import FusionMedia

class MainPageAdapter: SCDLatticePageAdapter {  
  var player: FusionMedia.AudioPlayer?  
      
  // page adapter initialization
  override func load(_ path: String) {  
    super.load(path)
        
    self.button1.onClick { [weak self] _ in      
      self?.player = FusionMedia.AudioPlayer(url: URL(forResource: "Assets/Ketsa-Good_Vibe.mp3"))
      self?.player?.play()
    }
  }
}
