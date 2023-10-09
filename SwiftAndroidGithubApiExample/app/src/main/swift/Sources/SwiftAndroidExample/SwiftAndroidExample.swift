
import Foundation
import Dispatch
import Java

// Downloads data from specified URL. Executes callback in main activity after download is finished.
@MainActor
public func downloadData(activity: JObject, url: String) async {

  var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
  request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
  request.addValue("Bearer XXXXXXX", forHTTPHeaderField: "Authorization")
  request.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")

  request.httpMethod = "GET"

  let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data else {
      print(String(describing: error))
       activity.call(method: "onDataLoaded", "Error")
      return
    }

    let dataStr = (String(data: data, encoding: .utf8)!)
    activity.call(method: "onDataLoaded", dataStr)

  }
  task.resume()
}

// NOTE: Use @_silgen_name attribute to set native name for a function called from Java
@_silgen_name("Java_com_example_swiftandroidexample_MainActivity_loadData")
public func MainActivity_loadData(env: UnsafeMutablePointer<JNIEnv>, activity: JavaObject, javaUrl: JavaString) {
    // Create JObject wrapper for activity object
    let mainActivity = JObject(activity)

    // Convert the Java string to a Swift string
    let str = String.fromJavaObject(javaUrl)

    // Start the data download asynchronously in the main actor
    Task {
        await downloadData(activity: mainActivity, url: str)
    }
}
