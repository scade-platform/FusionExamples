import Foundation
import ScadeKit
import ScadeExtensions
import FusionMedia

extension SCDWidgetsSliderLine {

  func onSlide(closure: @escaping (SCDWidgetsSliderLineEvent?) -> Void) {
    self.onSlide.append(SCDWidgetsSliderLineEventHandler(closure))
  }
}

class MainPageAdapter: SCDLatticePageAdapter {

  var player: FusionMedia.AudioPlayer? 
  let playImage = "./Assets/play1.svg"
  let stopImage = "./Assets/stop1.svg"

  let maxVolume = 100
  var duration: Double = 180

  var timer:Timer!
//  var dateComponent = DateComponentsFormatter()

  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)

	//setup player
    self.player = FusionMedia.AudioPlayer(url: URL(forResource: "Assets/Ketsa-Good_Vibe.mp3"))
    
	// setup slider
	if let player = self.player {
      self.positionSlide.maxValue = Int(player.duration)
      self.volumeSlide.maxValue = maxVolume
      self.volumeSlide.position = Int(player.volume * Float(maxVolume))
	}

    self.positionSlide.onSlide { e in self.onPositionChanged(ev: e) }
	self.volumeSlide.onSlide { e in self.onVolumeChanged(ev: e) }
	
	// setup stop/play button
    self.playStopButton.onClick { _ in self.playStopButtonClicked() }

	// configure date component
//    self.dateComponent.allowedUnits = [.minute, .second]
//    self.dateComponent.unitsStyle = .positional
//	self.dateComponent.zeroFormattingBehavior = .pad
  }

  func onPositionChanged(ev: SCDWidgetsSliderLineEvent?) {
    let sliderPosition = Double(ev!.newValue)

//    if let sliderPositionMinutesSeconds = self.dateComponent.string(from: sliderPosition) {
//     self.lblPlayPosition.text = sliderPositionMinutesSeconds
//    }
	player?.seek(to: sliderPosition)
  }

  func onVolumeChanged(ev: SCDWidgetsSliderLineEvent?) {
    let sliderPosition = ev!.newValue

	player?.volume = Float(sliderPosition) / Float(self.maxVolume)
  }
  
  func canChangeState() -> Bool {
    return true
  }

  func playStopButtonClicked() {

    guard let player = player else { return }

    // toggle state and change button accordingly

    let imageUrl = player.isPlaying ? playImage : stopImage
    self.playStopButton.url = imageUrl
	player.isPlaying ? player.stop() : player.play()
	
	timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
        self.positionSlide.position = Int(player.currentTime)
        if !player.isPlaying {
            timer.invalidate()
        }
	}
  }

}
