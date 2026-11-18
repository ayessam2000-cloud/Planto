import Foundation

// MARK: - Model (بيانات فقط)
struct Plant: Identifiable, Codable {
    var id = UUID()
    var name: String
    var room: String
    var light: String
    var days: String
    var water: String
    var isDone: Bool = false
}
