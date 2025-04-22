import SwiftData
import SwiftUI

struct TopBarView: View {
    var selectedHamzzang: Hamzzang
    @Query var notes: [Note]
    @Environment(\.modelContext) private var modelContext

    @State private var isPresentingNoteInput = false
    @State private var isPresentingNoteEdit = false
    @State private var isPresentingNoteList = false

    @State private var todayNote: Note? = nil

    var body: some View {
        HStack {
            Spacer()

            Button {
                isPresentingNoteList = true
            } label: {
                Image("listicon")
            }

            Spacer()

            Button {
                if let matchNote = notes.first(where: {
                    $0.hamzzang.id == selectedHamzzang.id &&
                    Calendar.current.isDate($0.createdAt, inSameDayAs: Date())
                }) {
                    // 노트있으면 수정
                    self.todayNote = matchNote
                    isPresentingNoteEdit = true
                } else {
                    // 노트없으면 작성
                    let newNote = Note(content: "", hamzzang: selectedHamzzang)
                    modelContext.insert(newNote)
                    self.todayNote = newNote
                    isPresentingNoteInput = true
                }
            } label: {
                Image("noteicon")
            }

            Spacer()

            Button {
                // 캘린더 뷰 이동
            } label: {
                Image("calendaricon")
            }

            Spacer()
        }
        .padding(.vertical, 30)

        // 노트 작성 뷰
        .fullScreenCover(isPresented: $isPresentingNoteInput) {
            NoteInputView(
                note: todayNote ?? Note(content: "", hamzzang: selectedHamzzang),
                selectedHamzzang: .constant(selectedHamzzang)
            )
        }

        // 노트 수정 뷰
        .fullScreenCover(isPresented: $isPresentingNoteEdit) {
            if let note = todayNote {
                NoteEditView(
                    note: note,
                    selectedHamzzang: .constant(selectedHamzzang))
            } else{
                Text("안되지롱")
                //뷰 바깥에서 조건을 분기해서 여기 넘길 뷰를 정하는 구조가 뭔데...
            }
        }

        // 노트 리스트
        .sheet(isPresented: $isPresentingNoteList) {
            NoteListView(selectedHamzzang: .constant(selectedHamzzang))
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Hamzzang.self, Note.self, configurations: .init(isStoredInMemoryOnly: true))
    let context = container.mainContext
    let sampleHamzzang = Hamzzang(name: "SwiftUI 햄짱이")

    return TopBarView(selectedHamzzang: sampleHamzzang)
        .modelContainer(container)
        .environment(\.modelContext, context)
}
