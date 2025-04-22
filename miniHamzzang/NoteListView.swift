import SwiftData
import SwiftUI

struct NoteListView: View {
    @Binding var selectedHamzzang: Hamzzang // 현재 선택된 햄짱이
    @State private var sortByNewest: Bool = true // 정렬 상태 토글
    @State private var hamNote: String = ""
    @Query private var notes: [Note] // SwiftData에서 필터링된 Note 가져오기

    @State private var isPresentingNoteEdit = false
    @State private var selectedNote: Note? = nil

    var body: some View {
        VStack(spacing: 0) {
            // MARK: 햄짱이 캐러셀

            HamCarouselView(hamzzangName: $selectedHamzzang.name)

            // MARK: 필터 및 정렬 토글

            HStack {
                Text("#오늘도실패완료")
                    .foregroundColor(.neonpink)
                    .font(.custom("DungGeunMo", size: 16))

                Spacer()

//                Button(action: {
//                    sortByNewest.toggle()
//                    // 정렬 기준 다시 적용(정렬방식 동적으로 구현 시 여기에 조건 넣기)
//                }) {
//                    Image(sortByNewest ? "newestSortIcon" : "oldestSortIcon") // 비트맵 이미지 넣기
//                        .resizable()
//                        .frame(width: 24, height: 24)
//                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 30)

            // MARK: 노트 작성 창

            TextField("오늘은 어떤 실패 근육을 키웠지..?", text: $hamNote, axis: .vertical)
                .foregroundColor(.black)
                .font(.custom("DungGeunMo", size: 16))
                .lineSpacing(5)
                .padding(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder()
                }
                .padding(.horizontal, 25)
                .padding(.top, 10)

            // MARK: 노트 리스트

            List {
                ForEach(notes) { note in
                    Button {
                        selectedNote = note
                        isPresentingNoteEdit = true                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(note.content)
                                .font(.custom("DungGeunMo", size: 18))

                            Text(note.createdAt, format: .dateTime.month().day().hour().minute())
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    @Previewable @State var previewHamzzang = Hamzzang(name: "SwiftUI 햄짱이")

    NoteListView(selectedHamzzang: $previewHamzzang)
}
