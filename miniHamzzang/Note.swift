import Foundation
import SwiftData

@Model
class Note {
    var id: UUID // 각 기록 고유 식별
    var content: String // 내용
    var createdAt: Date // 최초 기록 날짜
    @Relationship var hamzzang: Hamzzang // 어떤 햄짱이 기록인지(연결관계)

    init(content: String, createdAt: Date = Date(), hamzzang: Hamzzang) {
        self.id = UUID()
        self.content = content
        self.createdAt = createdAt
        self.hamzzang = hamzzang
    }
}
