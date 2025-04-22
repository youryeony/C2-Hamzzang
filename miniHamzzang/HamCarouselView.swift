import SwiftUI

struct HamCarouselView: View {
    @Binding var hamzzangName: String
    var limit: Int = 10
    var onLeftTap: () -> Void = {}
    var onRightTap: () -> Void = {}

    var body: some View {
        HStack {
            Button(action: onLeftTap) {
                Image("arrowleft")
            }

            TextField("이름을 입력하세요.", text: $hamzzangName)
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
                .onChange(of: hamzzangName) {
                    if hamzzangName.count > limit {
                        hamzzangName = String(hamzzangName.prefix(limit))
                    }
                }

            Button(action: onRightTap) {
                Image("arrowright")
            }
        }
        .font(.custom("DungGeunMo", size: 24))
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
}
