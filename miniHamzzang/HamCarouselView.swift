import SwiftUI

struct HamCarouselView: View {
    @Binding var hamzzangName: String
    var onLeftTap: () -> Void = {}
    var onRightTap: () -> Void = {}
    var isEditable: Bool = true

    var body: some View {
        HStack {
            Button(action: onLeftTap) {
                Image("arrowleft")
            }

            Text(hamzzangName)
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)

            Button(action: onRightTap) {
                Image("arrowright")
            }
        }
        .font(.custom("DungGeunMo", size: 24))
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
}
