import SwiftUI

struct AddTeamModal: View {
    @Environment(\.presentationMode) var presentation
    @State private var name = ""
    @State private var roster: [Player] = []
    @State private var showAddPlayer = false
    let addTeamCallback: (Team) -> Void
    
    var body: some View {
        VStack {
            TextField("Team Name" , text: $name)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .border(Color(UIColor.separator))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            // roster
            List(roster) { player in
                Text("\(player.jersey_number) \(player.given_name) \(player.family_name)")
            }
            // add player
            Button("Add Player") {
                showAddPlayer = true
            }.sheet(isPresented: $showAddPlayer) {
                AddPlayerModal(callback: AddPlayer)
            }
            HStack {
                Button("Cancel") {
                    self.presentation.wrappedValue.dismiss()
                }
                Spacer()
                Button("Submit") {
                    // TODO: validate data
                    addTeamCallback(Team(name: self.name, roster: Roster(player_list: roster)))
                    self.presentation.wrappedValue.dismiss()
                }
            }.padding()
        }
    }
    func AddPlayer(newPlayer: Player) {
        print("adding \(newPlayer.family_name)")
        roster.append(newPlayer)
    }
}
