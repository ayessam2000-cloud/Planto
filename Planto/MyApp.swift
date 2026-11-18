import SwiftUI
import UserNotifications

@main struct MyApp: App {
    init() {
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
        NotificationManager.shared.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            PlantsRootView()
        }
    }
}
