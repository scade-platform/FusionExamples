# FusionLocalAuthExample


### iOS
![ios_localauth](/LocalAuthenticationExample/screenshots/ios_localauth.gif) 


### Android
![android_localauath](/LocalAuthenticationExample/screenshots/android_localauth.gif) 


## Add FusionLocalAuth to `Package.swift`

```swift
// swift-tools-version:5.3

import Foundation
import PackageDescription

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
  name: "FusionLocalAuthExample",
  platforms: [
    .macOS(.v10_14)
  ],
  products: [
    .library(
      name: "FusionLocalAuthExample",
      type: .static,
      targets: [
        "FusionLocalAuthExample"
      ]
    )
  ],
  dependencies: [
    .package(
      name: "FusionLocalAuth", url: "https://github.com/scade-platform/FusionLocalAuth.git",
      .branch("main"))
  ],
  targets: [
    .target(
      name: "FusionLocalAuthExample",
      dependencies: [
        .product(name: "FusionLocalAuth", package: "FusionLocalAuth")
      ], exclude: ["main.page"],
      swiftSettings: [
        .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
        .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
      ]
    )
  ]
)


```


## Add Permissions to `build.yaml`

```swift
  plist:
    CFBundleShortVersionString: string# 1.0
    CFBundleVersion: string# 1
    NSLocationWhenInUseUsageDescription:
    NSCameraUsageDescription: Take pictures from camera
    NSPhotoLibraryUsageDescription: Choose a photo from your library
    NSFaceIDUsageDescription: Allow app to use Biometrics

android:
  name: FusionLocalAuthExample
  id: com.scade.fusionlocalauthexample
  version-name: 1.0.0
  version-code: 1
  build-type: Debug
  key-store-properties:
  google-api-key:
  manifest-file:
  permissions: [USE_FINGERPRINT, USE_BIOMETRIC]


```


## Import FusionLocalAuth

```swift
import FusionLocalAuth
```

## Use Library with Ease

```Swift
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

// Use requestDeviceAuthentication() for Android
/* localAuth!.requestDeviceAuthentication( 
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

      }) */

  }

}


```



## Contribution
<p>Consider contributing by creating a pull request (PR) or opening an issue. By creating an issue, you can alert the repository's maintainers to any bugs or missing documentation you've found. 🐛📝 If you're feeling confident and want to make a bigger impact, creating a PR, can be a great way to help others. 📖💡 Remember, contributing to open source is a collaborative effort, and any contribution, big or small, is always appreciated! 🙌 So why not take the first step and start contributing today? 😊</p>
