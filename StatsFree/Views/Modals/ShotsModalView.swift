import SwiftUI

struct ShotsModalView: View {
    @Environment(\.presentationMode) var presentation
    @State private var selectedPlayerIndex = 0
    @State private var shotResult = StatEventType.shotMissed
    let players: [Player] = []
    let callback: (StatEvent) -> Void
    
    
    var body: some View {
        VStack {
            Picker(selection: $selectedPlayerIndex, label: Text("Shooter")) {
                ForEach(0 ..< players.count) {
                    let player = players[$0]
                    Text("\(player.given_name) \(player.family_name) \(player.jersey_number)")
                }
            }
            Picker(selection: $shotResult, label: Text("Shot Result")) {
                Text("Miss").tag(StatEventType.shotMissed)
                Text("Save").tag(StatEventType.shotOnTarget)
                Text("Block").tag(StatEventType.shotBlocked)
                Text("Goal").tag(StatEventType.goalScored)
            }.pickerStyle(DefaultPickerStyle())
            Button("Submit") {
                let evt = StatEvent(actor: players[selectedPlayerIndex], event: shotResult, target: nil)
                callback(evt)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}
