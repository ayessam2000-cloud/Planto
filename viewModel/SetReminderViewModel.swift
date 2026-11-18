import Foundation
import Combine

// MARK: - ViewModel تبع فورم إضافة / تعديل النبتة
final class SetReminderViewModel: ObservableObject {

    @Published var name: String
    @Published var room: String
    @Published var light: String
    @Published var days: String
    @Published var water: String

    // الخيارات اللي بتظهر بالقوائم
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lights = ["Full sun", "Partial sun", "Low light"]
    let wateringDays = ["Every day", "Every 2 days", "Every 3 days", "Weekly"]
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]

    private let existing: Plant?

    var isEditing: Bool { existing != nil }

    init(existing: Plant? = nil) {
        self.existing = existing
        name = existing?.name ?? ""
        room = existing?.room ?? "Bedroom"
        light = existing?.light ?? "Full sun"
        days = existing?.days ?? "Every day"
        water = existing?.water ?? "20-50 ml"
    }

    // بترجع النبتة جاهزة، أو nil إذا الاسم فاضي
    func makePlant() -> Plant? {
        let n = name.trimmingCharacters(in: .whitespaces)
        guard !n.isEmpty else { return nil }

        if var p = existing {
            p.name = n
            p.room = room
            p.light = light
            p.days = days
            p.water = water
            return p
        }
        return Plant(name: n, room: room, light: light, days: days, water: water)
    }
}
