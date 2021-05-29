import SwiftUI

struct ShotsModalView: View {
    @Environment(\.presentationMode) var presentation
    @State private var selectedPlayerIndex = 0
    @State private var shotResult = StatEventType.shotMissed
    let players = [Player(given_name: "Dan", family_name: "Schey", jersey_number: 77), Player(given_name: "Tim", family_name: "Armstrong", jersey_number: 17), Player(given_name: "Andrew", family_name: "Jahan", jersey_number: 99)]
    //let game: Game
    
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
                print(evt.toString())
                
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}
