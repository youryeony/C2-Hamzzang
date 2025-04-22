import SwiftUI

struct ContentView: View {
    @State private var selection = 1

    var body: some View {
        TabView(selection: $selection) {
            HamzzangMainView(hamzzang: Hamzzang())
                .tabItem {
                    Image(selection == 1 ? "hamshill" : "hamshillbk")
                }
                .tag(1)

            HamzzangListView()
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
    ContentView()
}
