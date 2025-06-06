import SwiftData
import SwiftUI

struct NoteEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var note: Note
    @Binding var selectedHamzzang: Hamzzang // 현재 선택된 햄짱이
    @State private var sortByNewest: Bool = true // 정렬 상태 토글
    @State private var noteText: String = ""
    @Query private var notes: [Note] // SwiftData에서 필터링된 Note 가져오기
    
    let limit = 200
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: 햄짱이 캐러셀

            HamCarouselView(hamzzangName: $selectedHamzzang.name)
            
            // MARK: Note 수정창
            
            VStack {
                HStack {
                    Text(" #오늘실패완료")
                        .font(.custom("DungGeunMo", size: 18))
                        .foregroundStyle(Color.neonpink)
                    Spacer()
                }.padding(.top, 0)
                VStack {
                    TextField("흠.. 실패 근육을 키운다는 건 뭘까?", text: $noteText, axis: .vertical)
                        .onChange(of: noteText) {
                            if noteText.count > limit {
                                noteText = String(noteText.prefix(limit))
                            }
                        }
                        .lineLimit(15, reservesSpace: true)
                        .foregroundColor(Color.black)
                        .font(.custom("DungGeunMo", size: 18))
                        .lineSpacing(5)
                        .padding(.all, 20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(
                                )
                        }
                }
            }.padding(.horizontal, 25)
                .padding(.top, 20)
            
            // MARK: 수정, 삭제, 취소 버튼
            
            HStack {
                Button {
                    note.content = noteText
                    try? modelContext.save()
                    dismiss()
                } label: {
                    Text("수정")
                        .font(.custom("DungGeunMo", size: 20))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .buttonStyle(.bordered)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 3)
                        )
                        .background(Color.hills)
                        .cornerRadius(10)
                }
                
                Button {
                    modelContext.delete(note)
                    try? modelContext.save()
                    dismiss()
                } label: {
                    Text("삭제")
                        .font(.custom("DungGeunMo", size: 20))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .buttonStyle(.bordered)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 3)
                        )
                        .background(Color.bubble)
                        .cornerRadius(10)
                }
                
                Button {
                    dismiss()
                } label: {
                    Text("취소")
                        .font(.custom("DungGeunMo", size: 20))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .buttonStyle(.bordered)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 3)
                        )
                        .background(Color.grey)
                        .cornerRadius(10)
                }
            }
            .padding(.vertical, 8)
        }
        .onAppear {
            noteText = note.content
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Hamzzang.self, Note.self, configurations: .init(isStoredInMemoryOnly: true))
    let context = container.mainContext
    let previewHamzzang = Hamzzang(name: "SwiftUI 햄짱이")
    let previewNote = Note(content: "프리뷰 노트 내용", hamzzang: previewHamzzang)

    return NoteEditView(note: previewNote, selectedHamzzang: .constant(previewHamzzang))
        .modelContainer(container)
        .environment(\.modelContext, context)
}
