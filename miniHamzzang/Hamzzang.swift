import Foundation
import SwiftData

@Model
class Hamzzang {
    var name: String
    var createdAt: Date
    @Relationship(deleteRule: .cascade) var notes: [Note]

    init(name: String = "", createdAt: Date = Date(), level: Int = 0, notes: [Note] = []) {
        self.name = name
        self.createdAt = createdAt
        self.notes = notes
        // 외부에서 이 클래스 쓸 때 let myHamzzang = Hamzzang(name: "햄짱이1")
    }

    var level: Int {
        return notes.count
    }
}

// MODEL을하나로 구분
