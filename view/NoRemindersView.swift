import SwiftUI

struct NoRemindersView: View {
    var onAdd: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black
            VStack {
                PlantsHeader()
                Spacer()
                Text("No reminders set yet..")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top, 60)

            PlusButton(action: onAdd)
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    NoRemindersView(onAdd: {})
}
