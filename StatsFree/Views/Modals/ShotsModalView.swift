import SwiftUI

struct ShotsModalView: View {
    @Environment(\.presentationMode) var presentation
    @State private var selectedPlayerIndex = 0
    @State private var shotResult = StatEventType.shotMissed
    @State private var shotTargetIndex = 0
    private let _vm: ShotsModalVM
    let statsCollector: StatsCollectorVM
    let team: TeamLoc
    let sourcePlayers: [Player]
    let targetPlayers: [Player]
    
    init(statsVM: StatsCollectorVM, team: TeamLoc, ytWindow: YTWrapper) {
        self._vm = ShotsModalVM(ytWindow: ytWindow)
        self.statsCollector = statsVM
        self.team = team
        let home = statsCollector.homeTeam
        let away = statsCollector.awayTeam
        sourcePlayers = team == .home ? home.roster.player_list : away.roster.player_list
        targetPlayers = team == .home ? away.roster.player_list : home.roster.player_list
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
            HStack {
                Button("Cancel") {
                    self.presentation.wrappedValue.dismiss()
                }
                Button("Submit") {
                    let target = shotResult == StatEventType.shotBlocked ? targetPlayers[shotTargetIndex] : nil
                    let evt = StatEvent(timestamp: self._vm.timestamp, actor: self.sourcePlayers[selectedPlayerIndex], eventType: self.shotResult, target: target)
                    print(evt)
                    statsCollector.addEvent(event: evt)
                    self.presentation.wrappedValue.dismiss()
                }
            }
            
        }
    }
}
