struct StatEvent {
    let timestamp: Float
    let actor: Player
    let event: StatEventType
    let target: Player?
    
    func toString() -> String {
        let evtString = getStringFor(eventType: event)
        return "\(timestamp)sec: \(actor.given_name) \(actor.family_name) \(evtString)";
    }
    
    func getStringFor(eventType: StatEventType) -> String {
        switch(eventType) {
        case .shotBlocked:
            return "shot and was blocked by"
        case .goalScored:
            return "shot and scored"
        case .shotMissed:
            return "shot and missed the net"
        case .shotOnTarget:
            return "shot and was saved by"
        }
    }
}

enum StatEventType {
    case shotOnTarget, shotBlocked, shotMissed, goalScored
}
