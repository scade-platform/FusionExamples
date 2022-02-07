import ScadeKit
import FusionCamera
  
class MainPageAdapter: SCDLatticePageAdapter {

  var camera: CameraProtocol?

  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)

    self.camera = self.videoCaptureView.camera

    self.button.onClick { [weak self] _ in
      self?.videoCaptureView.start()
    }

    self.button1.onClick { [weak self] _ in
      self?.videoCaptureView.stop()
    }
    
    self.camera?.setup { [weak self] data in
      print(data)
      self?.videoCaptureView.stop()
    }
  }
}
