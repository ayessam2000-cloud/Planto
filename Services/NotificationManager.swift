import UserNotifications

// MARK: - إدارة إشعارات التذكير بالسقاية
final class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    func requestPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    /// يجدول إشعار متكرر حسب "Watering Days" للنبتة
    func schedule(for plant: Plant) {
        cancel(plant)

        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your plant"
        content.sound = .default

        let trigger: UNNotificationTrigger
        switch plant.days {
        case "Every day":
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        case "Every 2 days":
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2 * 86_400, repeats: true)
        case "Every 3 days":
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3 * 86_400, repeats: true)
        default: // Weekly
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7 * 86_400, repeats: true)
        }

        let request = UNNotificationRequest(identifier: plant.id.uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func cancel(_ plant: Plant) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }
}

// MARK: - يخلي الإشعار يظهر حتى لو التطبيق مفتوح
final class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationDelegate()

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
