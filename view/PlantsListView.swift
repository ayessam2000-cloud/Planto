
import SwiftUI

// MARK: - Today Reminder + Delete Plant (swipe)

struct PlantsListView: View {

    let plants: [Plant]
    let doneCount: Int
    let progress: Double

    var onToggle: (Plant) -> Void
    var onDelete: (Plant) -> Void
    var onEdit: (Plant) -> Void
    var onAdd: () -> Void

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            Color.black

            VStack(alignment: .leading, spacing: 0) {

                PlantsHeader()
                    .padding(.horizontal, 30)

                // MARK: Progress

                VStack(spacing: 10) {

                    Text(
                        doneCount == 0
                        ? "Your plants are waiting for a sip 💦"
                        : "\(doneCount) of your plants feel loved today✨"
                    )
                    .font(.system(size: 14))
                    .foregroundColor(.white)

                    GeometryReader { geo in

                        ZStack(alignment: .leading) {

                            Capsule()
                                .fill(Color.white.opacity(0.15))

                            Capsule()
                                .fill(Color.plantGreen)
                                .frame(width: geo.size.width * progress)
                                .animation(.easeInOut, value: progress)
                        }
                    }
                    .frame(height: 6)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)

                // MARK: List

                List {

                    ForEach(plants) { plant in

                        PlantRow(
                            plant: plant,
                            onToggle: {
                                onToggle(plant)
                            },
                            onTap: {
                                onEdit(plant)
                            }
                        )
                        .listRowBackground(Color.clear)
                        .listRowSeparatorTint(Color.white.opacity(0.1))
                        .listRowInsets(
                            EdgeInsets(
                                top: 0,
                                leading: 30,
                                bottom: 0,
                                trailing: 30
                            )
                        )
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {

                            Button(role: .destructive) {
                                onDelete(plant)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .padding(.top, 60)

            PlusButton(action: onAdd)
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}

// MARK: - Plant Row

struct PlantRow: View {

    let plant: Plant

    var onToggle: () -> Void
    var onTap: () -> Void

    var body: some View {

        HStack(spacing: 14) {

            Button(action: onToggle) {

                if plant.isDone {

                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.plantMint)

                } else {

                    Image(systemName: "circle")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {

                HStack(spacing: 4) {

                    Image(systemName: "location")
                    Text("in \(plant.room)")
                }
                .font(.caption)
                .foregroundColor(.gray)

                Text(plant.name)
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(plant.isDone ? .gray : .white)

                HStack(spacing: 6) {

                    tag(
                        icon: "sun.max",
                        text: plant.light,
                        color: Color(red: 0.85, green: 0.8, blue: 0.4)
                    )

                    tag(
                        icon: "drop",
                        text: plant.water,
                        color: .white
                    )
                }
            }
            .contentShape(Rectangle())
            .onTapGesture(perform: onTap)

            Spacer()
        }
        .padding(.vertical, 12)
        .opacity(plant.isDone ? 0.7 : 1)
    }

    private func tag(
        icon: String,
        text: String,
        color: Color
    ) -> some View {

        HStack(spacing: 4) {

            Image(systemName: icon)
            Text(text)
        }
        .font(.caption2)
        .foregroundColor(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color(white: 0.17))
        .clipShape(Capsule())
    }
}

// MARK: - Preview

#Preview {

    PlantsListView(

        plants: [
            Plant(
                name: "Monstera",
                room: "Kitchen",
                light: "Full sun",
                days: "Every day",
                water: "20-50 ml"
            ),

            Plant(
                name: "Pothos",
                room: "Bedroom",
                light: "Full sun",
                days: "Every day",
                water: "20-50 ml",
                isDone: true
            )
        ],

        doneCount: 1,
        progress: 0.5,

        onToggle: { _ in },
        onDelete: { _ in },
        onEdit: { _ in },
        onAdd: {}
    )
}
