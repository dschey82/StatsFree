import Foundation

struct Team: Hashable, Identifiable, Codable {
    internal init(id: UUID, name: String, roster: Roster) {
        self.id = id
        self.name = name
        self.roster = roster
    }
    
    init(name: String, roster: Roster) {
        self.id = UUID()
        self.name = name
        self.roster = roster
    }
    
    init(name: String, player_list: [Player])
    {
        self.id = UUID()
        self.name = name
        self.roster = Roster(player_list: player_list)
    }
    
    let id: UUID
    let name: String
    let roster: Roster
}
