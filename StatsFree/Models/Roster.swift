import Foundation

struct Roster: Hashable, Codable {
    let player_list: [Player]
    
    func getPlayer(id: UUID) -> Player? {
        for player in player_list {
            if (player.id == id) {
                return player
            }
        }
        return nil
    }
    
    var count: Int {
        return player_list.count
    }

    subscript(index: Int) -> Player {
        get {
            return player_list[index]
        }
    }
    

}
