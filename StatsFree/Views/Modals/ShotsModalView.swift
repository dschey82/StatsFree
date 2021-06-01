import SwiftUI

struct ShotsModalView: View {
    @Environment(\.presentationMode) var presentation
    @State private var selectedPlayerIndex = 0
    @State private var shotResult = StatEventType.shotMissed
    @State private var shotTargetIndex = 0
    let game: Game
    let homeTeam: Bool
    let callback: (StatEvent) -> Void
    let sourcePlayers: [Player]
    let targetPlayers: [Player]
    let timestamp: Float
    
    init(game: Game, homeTeam: Bool, timestamp: Float, callback: @escaping (StatEvent) -> Void) {
        self.game = game
        self.homeTeam = homeTeam
        self.timestamp = timestamp
        self.callback = callback
        sourcePlayers = homeTeam ? game.home.roster.player_list : game.away.roster.player_list
        targetPlayers = homeTeam ? game.away.roster.player_list : game.home.roster.player_list
    }
    
    var body: some View {
        VStack {
            Picker(selection: $selectedPlayerIndex, label: Text("Shooter")) {
                ForEach(0 ..< sourcePlayers.count) {
                    let player = sourcePlayers[$0]
                    Text("\(player.given_name) \(player.family_name) \(player.jersey_number)")
                }
            }
            Picker(selection: $shotResult, label: Text("Shot Result")) {
                Text("Miss").tag(StatEventType.shotMissed)
                Text("Save").tag(StatEventType.shotOnTarget)
                Text("Block").tag(StatEventType.shotBlocked)
                Text("Goal").tag(StatEventType.goalScored)
            }.pickerStyle(DefaultPickerStyle())
            if (shotResult == StatEventType.shotBlocked){
                Picker(selection: $shotTargetIndex, label: Text("Blocker")) {
                    ForEach(0 ..< targetPlayers.count) {
                        let player = targetPlayers[$0]
                        Text("\(player.given_name) \(player.family_name) \(player.jersey_number)")
                    }
                }
            }
            
            Button("Submit") {
                let target = shotResult == StatEventType.shotBlocked ? targetPlayers[shotTargetIndex] : nil
                let evt = StatEvent(timestamp: self.timestamp, actor: self.sourcePlayers[selectedPlayerIndex], event: self.shotResult, target: target)
                callback(evt)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}
