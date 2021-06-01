import SwiftUI

struct AddTeamModal: View {
    @Environment(\.presentationMode) var presentation
    @State private var name = ""
    @State private var roster: [Player] = []
    @State private var showAddPlayer = false
    private var id: UUID
    let callback: (Team) -> Void
    
    init(team: Team, callback: @escaping (Team) -> Void) {
        self.callback = callback
        id = team.id
        _name = State(initialValue: team.name)
        _roster = State(initialValue: team.roster.player_list)
    }
    
    init(callback: @escaping (Team) -> Void) {
        id = UUID()
        self.callback = callback
    }
    
    var body: some View {
        VStack {
            TextField("Team Name" , text: self.$name)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .border(Color(UIColor.separator))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            // roster
            List(roster) { player in
                Text("\(player.jersey_number) \(player.given_name) \(player.family_name)")
            }.id(UUID())
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
                    callback(Team(id: self.id, name: self.name, roster: Roster(player_list: roster)))
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
