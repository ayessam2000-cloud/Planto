import SwiftUI

// MARK: - Start screen
struct MyPlantsEmptyView: View {
    var onSetReminder: () -> Void = {}

    var body: some View {
        VStack(spacing: 0) {

            VStack(alignment: .leading, spacing: 12) {
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                Rectangle()
                    .fill(Color.white.opacity(0.15))
                    .frame(height: 1)
            }
            .padding(.horizontal, 30)
            .padding(.top, 60)

            Image("Plant-transparent-cropped")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .padding(.top, 100)

            Text("Start your plant journey!")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 30)

            Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.57))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 10)

            Button(action: onSetReminder) {
                Text("Set Plant Reminder")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.plantGreen)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.white.opacity(0.25), lineWidth: 1))
            }
            .padding(.horizontal, 40)
            .padding(.top, 30)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    PlantsRootView()
}
