import SwiftUI

// MARK: - All Reminders Completed
struct AllDoneView: View {
    var onAdd: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black

            VStack(spacing: 0) {
                PlantsHeader()
                    .padding(.horizontal, 30)

                Spacer()

                Image("Group 3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)

                Text("All Done! 🎉")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 30)

                Text("All Reminders Completed")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.top, 8)

                Spacer()
                Spacer()
            }
            .padding(.top, 60)

            PlusButton(action: onAdd)
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AllDoneView(onAdd: {})
}
