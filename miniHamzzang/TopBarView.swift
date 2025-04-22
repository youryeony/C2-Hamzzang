import SwiftData
import SwiftUI

struct TopBarView: View {
    var selectedHamzzang: Hamzzang
    @Query var notes: [Note]
    @Environment(\.modelContext) private var modelContext // SwiftData가 자동으로 주입해주는 DB 접근권한
    
    @State private var isPresentingNoteInput = false
    @State private var isPresentingNoteEdit = false
    @State private var todayNote: Note? = nil
    @State private var isPresentingNoteList = false
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                isPresentingNoteList = true
            }
            label: {
                Image("listicon")
            }
            
            Spacer()
            Button {
                if let todayNote = notes.first(
                    where: {
                        $0.hamzzang.id == selectedHamzzang.id &&
                        Calendar.current.isDate($0.createdAt, inSameDayAs: Date())
                    }
                ) {
                    self.todayNote = todayNote
                    isPresentingNoteEdit = true
                    // NoteEditView(note: todayNote)
                } else {
                    let newNote = Note(content: "", hamzzang: selectedHamzzang)
                    modelContext.insert(newNote)
                    todayNote = newNote
                    isPresentingNoteInput = true
                    // NoteInputView(for: selectedHamzzang)
                }
            } label: {
                Image("noteicon")
            }
            
            Spacer()
            Button {
                // 캘린더 뷰 이동
            }
            label: {
                Image("calendaricon")
            }
            
            Spacer()
        }.padding(.vertical, 30)
            .fullScreenCover(isPresented: $isPresentingNoteInput) {
                NoteInputView(
                    note: todayNote ?? Note(content: "", hamzzang: selectedHamzzang),
                    selectedHamzzang: .constant(selectedHamzzang)
                )
            }
            .fullScreenCover(isPresented: $isPresentingNoteEdit) {
                NoteEditView(
                    note: todayNote ?? Note(content: "", hamzzang: selectedHamzzang),
                    selectedHamzzang: .constant(selectedHamzzang)
                )
                
                if let note = todayNote {
                    NoteEditView(note: note, selectedHamzzang: .constant(selectedHamzzang))
                } else {
                    Text("노트를 불러올 수 없습니다")
                }
            }
            .sheet(isPresented: $isPresentingNoteList) {
                NoteListView(selectedHamzzang: .constant(selectedHamzzang))
            }
    }
}

// notes.first {
//       Calendar.current.isDate($0.createdAt, inSameDayAs: Date())
//   }

#Preview {
    let container = try! ModelContainer(for: Hamzzang.self, Note.self, configurations: .init(isStoredInMemoryOnly: true))
    let context = container.mainContext
    let sampleHamzzang = Hamzzang(name: "SwiftUI 햄짱이")

    return TopBarView(selectedHamzzang: sampleHamzzang)
        .modelContainer(container)
        .environment(\.modelContext, context)
}
