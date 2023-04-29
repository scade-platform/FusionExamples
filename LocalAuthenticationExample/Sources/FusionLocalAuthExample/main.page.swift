import FusionLocalAuth
import ScadeKit

class MainPageAdapter: SCDLatticePageAdapter {

  var localAuth: LocalAuthManager?

  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)
    localAuth = LocalAuthManager()

    let bool = localAuth!.canAuthenticateWithBiometrics()
    if !bool {
      self.label.text = "The device can't authenticate using Biometrics!"
      print("doesn't work'")
    } else {

      self.label.text = "The device can authenticate with biometrics"
    }

    localAuth!.requestBiometricAuthentication(
      authTitle: "Please Authenticate!", reasonTitle: "This is required to access app.",
      cancelTitle: "Cancel authentication",
      completionStatus: { [weak self] (success, error) in
        guard let S = self else { return }
        guard success else {
          print(error?.description)
          // S.label2.text = "Auth Failed"
          print("Authentication denied.")
          return
        }
        print("Authentication successful")

        ///S.label2.text = "Auth Successful"

      })

  }

}
