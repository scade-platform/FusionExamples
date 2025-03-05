import ScadeKit
import FusionNotifications
  
class TimerPagePageAdapter: SCDLatticePageAdapter {
  
  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)
    
    let actions = [
      NotificationAction(identifier: "acc_Accept", title: "Accept"),
      NotificationAction(identifier: "acc_Reject", title: "Reject")
    ]
    let category = NotificationCategory(identifier: "Notification.Category.Read", actions: actions)

    NotificationManager.shared.delegate = self
    NotificationManager.shared.registerNotificationCategory(category: category)

	self.sendButton.onClick{_ in self.send()}

  }
  
  func send() {
    let content = NotificationContent(title: self.titleTextfield.text, body: self.bodyTextfield.text, category: "Notification.Category.Read")
    let trigger = TimeNotificationTrigger(timeInterval: 10, repeats: false)

    NotificationManager.shared.add(identifier: "Local notification",  content: content,  trigger: trigger)    
  }
}

extension TimerPagePageAdapter: NotificationDelegate {
  func didReceive(notification: FusionNotifications_Common.Notification, userActionIdentifier: String) {
    guard let content = notification.content else { return }
    if userActionIdentifier == "acc_Accept" {
      print("User accepted \(content.body)")
    } else if userActionIdentifier == "acc_Reject" {
      print("User rejected \(content.body)")
    }
  }
  
  func willPresent(notification: FusionNotifications_Common.Notification) {
    guard let content = notification.content else { return }
    print("Content body = \(content.body)")
  }
}