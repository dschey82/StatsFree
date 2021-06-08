import Foundation

class StatsCollectorVM {
    private var _game: Game
    private var _statEvents: [StatEvent]
    private var _onIceLineups: [TeamLoc: [UUID: Bool]]
    
    init(game: Game) {
        _game = game
        _statEvents = [StatEvent]()
        
        // initialize On-Ice tracker
        _onIceLineups = [TeamLoc: [UUID: Bool]]()
        _onIceLineups[.home] = [UUID:Bool]()
        for player in game.home.roster.player_list {
            _onIceLineups[.home]?.updateValue(false, forKey: player.id)
        }
        _onIceLineups[.away] = [UUID:Bool]()
        for player in game.away.roster.player_list {
            _onIceLineups[.away]?.updateValue(false, forKey: player.id)
        }
    }
    
    public var homeTeam: Team {
        return _game.home
    }
    
    public var awayTeam: Team {
        return _game.away
    }
    
    public func getRoster(team: TeamLoc) -> Roster {
        return team == .home ? _game.home.roster : _game.away.roster
    }
    
    public func getOnIceRoster(team: TeamLoc) -> [UUID: Bool] {
        return _onIceLineups[team]!
    }
    
    public func updateOnIceRoster(active: [UUID: Bool], team: TeamLoc, timestamp: Float) {
        let prevRoster = _onIceLineups[team]!
        for (key,value) in active {
            if (prevRoster[key] != value) {
                let onOffIce = value ? StatEventType.enteredIce : StatEventType.leftIce
                let player = _game[team].roster.getPlayer(id: key)
                let evt = StatEvent(timestamp: timestamp, actor: player!, eventType: onOffIce, target: nil)
                addEvent(event: evt)
            }
        }
        _onIceLineups[team] = active
    }
    
    public func getTimeOnIceStats(team: TeamLoc) -> [Player: Int] {
        let iceTimeEvents = _statEvents.filter { event in
            event.eventType == StatEventType.enteredIce || event.eventType == StatEventType.leftIce
        }
        var timeTracker = [Player: Float]()
        var lastOn = [Player: Float]()
        for event in iceTimeEvents {
            if event.eventType == .enteredIce {
                lastOn[event.actor] = event.timestamp
                print("added \(event.actor) to lastOn at \(event.timestamp)")
            }
            else {
                timeTracker[event.actor] = (timeTracker[event.actor] ?? 0.0) + (event.timestamp - lastOn[event.actor]!)
                print("timetracker for \(event.actor) is now \(timeTracker[event.actor] ?? 0.0)")
                lastOn[event.actor] = nil
                
            }
        }
        // get last set of players ice times
        for player in lastOn {
            timeTracker[player.key] = (timeTracker[player.key] ?? 0.0) + (3600.0 - player.value)
        }
        
        var retDict = [Player: Int]()
        for entry in timeTracker {
            retDict[entry.key] = Int(entry.value)
            print("\(entry.key) \(entry.value)")
        }
        return retDict
    }
    
    public func addEvent(event: StatEvent)->Void {
        print(event)
        _statEvents.append(event)
    }
    
    public func getEvents() -> [StatEvent] {
        return _statEvents
    }
}
