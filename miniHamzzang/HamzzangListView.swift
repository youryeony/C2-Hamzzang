import SwiftData
import SwiftUI

struct HamzzangListView: View {
    @Binding var selectedHamzzang: Hamzzang

    var body: some View {
        Text("Where are you, Hamzzang?")
            .multilineTextAlignment(.center)
            .font(.custom("DungGeunMo", size: 24))
    }
}

#Preview {
    @State var previewHamzzang = Hamzzang(name: "프리뷰 햄짱")
    return HamzzangListView(selectedHamzzang: $previewHamzzang)
}
