import Foundation

struct PlayerStats {
    private var _shots: Int  // shots saved
    private var _shotsMissed: Int
    private var _shotsBlocked: Int
    private var _goals: Int
    private var _timeOnIce: Int
    private var _events: [StatEvent]
    
    init() {
        _shots = 0
        _shotsMissed = 0
        _shotsBlocked = 0
        _goals = 0
        _timeOnIce = 0
        _events = [StatEvent]()
    }
}
