struct Game {
    let videoId: String
    let home: Team
    let away: Team
    private let statEvents: [StatEvent] = []
    
    subscript(team: TeamLoc) -> Team {
        get {
            return team == TeamLoc.home ? home : away
        }
    }
}
