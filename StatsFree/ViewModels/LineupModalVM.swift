import Foundation

class LineupModalVM {
    private var _onIce: [UUID: Bool]
    private var ytWindow: YTWrapper
    private var timestamp: Float
    
    init(initial: [UUID: Bool], ytWindow: YTWrapper) {
        self._onIce = initial
        self.ytWindow = ytWindow
        self.timestamp = 0.0
        self.ytWindow.getTime(handler: { result, err in
            self.timestamp = result
        })
    }
    
    public var videoTime: Float {
        get {
            return timestamp
        }
    }
    
    public func getIsOnIce(playerId: UUID, team: TeamLoc) -> Bool {
        return _onIce[playerId]!
    }
    
    public func setIsOnIce(playerId: UUID, team: TeamLoc, isOn: Bool) {
        _onIce.updateValue(isOn, forKey: playerId)
    }
    
    public func getOnIceRoster() -> [UUID: Bool] {
        return _onIce
    }
}
