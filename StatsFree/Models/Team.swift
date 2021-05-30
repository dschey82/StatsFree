import Foundation

struct Team: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let roster: Roster
}
