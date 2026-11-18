import SwiftUI

// MARK: - Set Reminder (Add) + Delete / Edit Plant
struct SetReminderView: View {
    @StateObject private var viewModel: SetReminderViewModel
    var onSave: (Plant) -> Void
    var onDelete: (() -> Void)? = nil

    @Environment(\.dismiss) private var dismiss

    private let field = Color(white: 0.17)

    init(plant: Plant? = nil,
         onSave: @escaping (Plant) -> Void,
         onDelete: (() -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: SetReminderViewModel(existing: plant))
        self.onSave = onSave
        self.onDelete = onDelete
    }

    var body: some View {
        ZStack {
            Color(white: 0.11).ignoresSafeArea()

            VStack(spacing: 24) {
                // MARK: Top bar
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(field)
                            .clipShape(Circle())
                    }
                    Spacer()
                    Text("Set Reminder")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Button { save() } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.plantGreen)
                            .clipShape(Circle())
                    }
                }

                // MARK: Name
                HStack(spacing: 8) {
                    Text("Plant Name").foregroundColor(.white)
                    TextField("", text: $viewModel.name,
                              prompt: Text("Pothos").foregroundColor(.gray))
                        .foregroundColor(.white)
                        .tint(.plantGreen)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 18)
                .background(field)
                .clipShape(Capsule())

                card {
                    row("location", "Room", $viewModel.room, viewModel.rooms)
                    Divider().overlay(Color.white.opacity(0.1))
                    row("sun.max", "Light", $viewModel.light, viewModel.lights)
                }

                card {
                    row("drop", "Watering Days", $viewModel.days, viewModel.wateringDays)
                    Divider().overlay(Color.white.opacity(0.1))
                    row("drop", "Water", $viewModel.water, viewModel.waterAmounts)
                }

                // MARK: Delete (edit mode only)
                if viewModel.isEditing {
                    Button {
                        onDelete?()
                        dismiss()
                    } label: {
                        Text("Delete Reminder")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(field)
                            .clipShape(Capsule())
                    }
                    .padding(.top, 10)
                }

                Spacer()
            }
            .padding(20)
        }
        .preferredColorScheme(.dark)
    }

    private func save() {
        if let plant = viewModel.makePlant() {
            onSave(plant)
        }
        dismiss()
    }

    private func card<C: View>(@ViewBuilder _ content: () -> C) -> some View {
        VStack(spacing: 0) { content() }
            .background(field)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private func row(_ icon: String, _ title: String,
                     _ value: Binding<String>, _ options: [String]) -> some View {
        HStack {
            Image(systemName: icon)
            Text(title)
            Spacer()
            Menu {
                Picker(title, selection: value) {
                    ForEach(options, id: \.self) { Text($0).tag($0) }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(value.wrappedValue)
                    Image(systemName: "chevron.up.chevron.down").font(.caption2)
                }
                .foregroundColor(.gray)
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    SetReminderView(plant: Plant(name: "Pothos", room: "Bedroom", light: "Full sun",
                                 days: "Every day", water: "20-50 ml"),
                    onSave: { _ in }, onDelete: {})
}
