import SwiftData
import SwiftUI

struct HamzzangMainView: View {
    @Bindable var hamzzang: Hamzzang
    
    let limit = 10
    
    @State private var selectedDate = Date.now
    @State private var hamNote: String = ""
    @Query private var notes: [Note] // SwiftData에서 필터링된 Note 가져오기
    @Environment(\.modelContext) private var modelContext // SwiftData가 자동으로 주입해주는 DB 접근권한
    
    // @FocusState private var isNameFieldFocused: Bool // TextField 포커스 상태 감지
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Circle()
                    .frame(
                        width: geometry.size.width * 3.5,
                        height: geometry.size.width * 2
                    )
                    .foregroundColor(.hills)
                    .position(x: 500, y: 940)
            }
            GeometryReader { geometry in
                Circle()
                    .frame(
                        width: geometry.size.width * 3,
                        height: geometry.size.width * 2
                    )
                    .foregroundColor(.hills)
                    .position(x: 130, y: 930)
            }
            VStack(spacing: 0) {
                // MARK: 상단 아이콘 바

//                Button {
//                    print(notes)
//                } label: {
//                    Text("HIHIHIHIIHIHI").font(.system(size: 50))
//                }

                TopBarView(selectedHamzzang: Hamzzang())
                ScrollView {
                    Spacer()
                    VStack(spacing: 20) {
                        // MARK: 말풍선

                        VStack(alignment: .leading, spacing: 6) {
                            Group {
                                Text("나만의 목표 이름을\n먼저 정해볼까?")
                                Text("그리고 #오늘실패완료 기록을 하며\n실패 근육을 키워가는거야..!")
                            }
                            .font(.custom("DungGeunMo", size: 18))
                        }
                        .padding()
                        .background(Color.bubble.opacity(0.7))
                        .cornerRadius(20)
                        .padding(.vertical, 30)
                        
                        // MARK: 말풍선 꼬리
                        
                        VStack(spacing: 4) {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.bubble)
                                .opacity(0.7)
                                .padding(.leading, 200)
                            
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.bubble)
                                .opacity(0.7)
                                .padding(.leading, 170)
                        }
                        
//                        Spacer()
                        .frame(height: 12)
                        
                        // MARK: 햄짱이 이미지
                        
                        VStack {
                            if hamzzang.name.isEmpty {
                                Image("HamzzangX")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 143, height: 143)
                            } else {
                                Image("type1_lv0")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 143, height: 143)
                            }
                            
                            Spacer().frame(height: 12)
                            
                            // MARK: 햄짱이 이름칸
                            
                            TextField("이름을 입력하세요", text: $hamzzang.name)
                                .padding(.horizontal, 30)
                                .multilineTextAlignment(.center)
                                .onChange(of: hamzzang.name) {
                                    if hamzzang.name.count > limit {
                                        hamzzang.name = String(hamzzang.name.prefix(limit))
                                    }
                                }

                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 30)
                                .padding(.top, 2)
                        }
                        .padding(.horizontal, 30)
                        .font(.custom("DungGeunMo", size: 24))
                    }
                    
                    // MARK: 하단 레벨, 생성날짜
                        
                    VStack(spacing: 8) {
                        //            Spacer()
                        //            VStack(spacing: 8)
                        Text("Lv.\(hamzzang.level)")
                            .foregroundColor(.gray)
                            .font(.custom("DungGeunMo", size: 24))
                            
                        Text(dateToString(date: selectedDate))
                            .foregroundColor(.black)
                            .font(.custom("DungGeunMo", size: 20))
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 120)
                }
            }
        }
    }
}

func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy년 MMM dd일"
    return formatter.string(from: date)
}

#Preview {
    let preview = try! ModelContainer(for: Hamzzang.self, configurations: .init(isStoredInMemoryOnly: true))
    let sampleHamzzang = Hamzzang(name: "SwiftUI 햄짱이", level: 1)
    let sampleNote = Note(content: "프리뷰용 노트", hamzzang: sampleHamzzang)
    return HamzzangMainView(hamzzang: sampleHamzzang)
        .modelContainer(preview)
}

//            VStack(spacing: 20) {
//                TextField("이름을 입력하세요", text: $hamzzang.name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//
//                Text("\(hamzzang.createdAt.formatted(date: .long, time: .omitted))")
//                Text("Lv.\(hamzzang.level)")
//            }
