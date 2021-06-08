struct StatEvent {
    let timestamp: Float
    let actor: Player
    let eventType: StatEventType
    let target: Player?
    
    func toString() -> String {
        let evtString = getStringFor(eventType: eventType)
        return "\(timestamp)sec: \(actor.given_name) \(actor.family_name) \(evtString)";
    }
    
    func getStringFor(eventType: StatEventType) -> String {
        switch(eventType) {
        case .shotBlocked:
            return "shot and was blocked by"
        case .goalScored:
            return "shot and scored."
        case .shotMissed:
            return "shot and missed the net."
        case .shotOnTarget:
            return "shot and was saved by"
        case .enteredIce:
            return "entered the ice."
        case .leftIce:
            return "left the ice."
        }
    }
}

enum StatEventType {
    case shotOnTarget, shotBlocked, shotMissed, goalScored
    case enteredIce, leftIce
}
