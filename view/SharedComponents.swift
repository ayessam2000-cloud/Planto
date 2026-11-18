import SwiftUI

// MARK: - Header
struct PlantsHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("My Plants 🌱")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color.white.opacity(0.15))
                .frame(height: 1)
        }
    }
}

// MARK: - Plus Button
struct PlusButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(Color.plantGreen)
                .clipShape(Circle())
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
    }
}
