import Foundation
import Combine

// MARK: - أي شاشة منبثقة مفتوحة
enum PlantSheet: Identifiable {
    case add
    case edit(Plant)

    var id: String {
        switch self {
        case .add: return "add"
        case .edit(let p): return p.id.uuidString
        }
    }
}

// MARK: - ViewModel
class PlantsViewModel: ObservableObject {
    @Published var plants: [Plant] = []
    @Published var started = false {
        didSet { defaults.set(started, forKey: Keys.started) }
    }
    @Published var sheet: PlantSheet?

    // MARK: Storage
    private let defaults = UserDefaults.standard

    private enum Keys {
        static let plants = "savedPlants"
        static let started = "started"
    }

    init() {
        if let data = defaults.data(forKey: Keys.plants),
           let saved = try? JSONDecoder().decode([Plant].self, from: data) {
            plants = saved
        }
        started = defaults.bool(forKey: Keys.started)
    }

    private func save() {
        if let data = try? JSONEncoder().encode(plants) {
            defaults.set(data, forKey: Keys.plants)
        }
    }

    // MARK: Computed
    var doneCount: Int {
        plants.filter { $0.isDone }.count
    }

    var allDone: Bool {
        !plants.isEmpty && plants.allSatisfy { $0.isDone }
    }

    var progress: Double {
        plants.isEmpty ? 0 : Double(doneCount) / Double(plants.count)
    }

    // MARK: Actions
    func add(_ plant: Plant) {
        plants.append(plant)
        save()
        NotificationManager.shared.schedule(for: plant)
        started = true
    }

    func toggle(_ plant: Plant) {
        guard let i = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[i].isDone.toggle()
        save()
    }

    func delete(_ plant: Plant) {
        NotificationManager.shared.cancel(plant)
        plants.removeAll { $0.id == plant.id }
        save()
    }

    func update(_ plant: Plant) {
        guard let i = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[i] = plant
        save()
        NotificationManager.shared.schedule(for: plant)
    }
}
