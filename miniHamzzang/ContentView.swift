import SwiftData
import SwiftUI

struct ContentView: View {
    // SwiftData 모델 인스턴스 생성(저장 가능한 데이터 모델)
    @State private var hamzzang = Hamzzang(name: "") // 초기값은 빈칸 햄짱이

    @State private var selection = 1

    var body: some View {
        TabView(selection: $selection) {
            HamzzangMainView(hamzzang: hamzzang) // Bindable로 넘겨줄 거
                .tabItem {
                    Image(selection == 1 ? "hamshill" : "hamshillbk")
                }
                .tag(1)

            HamzzangListView(selectedHamzzang: $hamzzang) // @Binding이니까 $ 붙임
                .tabItem {
                    Image(selection == 2 ? "hamface" : "hamfacebk")
                }
                .tag(2)

            DataAnalysisView()
                .tabItem {
                    Image(selection == 3 ? "mydata" : "mydatabk")
                }
                .tag(3)
        }
        .font(.custom("DungGeunMo", size: 20))
    }
}

#Preview {
    let container = try! ModelContainer(
        for: Hamzzang.self, Note.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    return ContentView()
        .modelContainer(container)
}
