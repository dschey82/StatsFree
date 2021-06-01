import SwiftUI

struct ManageTeamsView: View {
    @Environment(\.presentationMode) var presentation
    @State private var selectedTeamIndex = 0
    @State private var teams = [Team]()
    @State private var showAddTeamModal = false
    @State private var showEditTeamModal = false
    let callback: ([Team]) -> Void
    
    init(callback: @escaping ([Team]) -> Void) {
        self.callback = callback
    }
    init(teams: [Team], callback: @escaping ([Team]) -> Void) {
        _teams = State(initialValue: teams)
        self.callback = callback
    }
    
    var body: some View {
        VStack {
            Text("Manage Teams")
            HStack {
                Picker("Team Picker", selection: $selectedTeamIndex) {
                    ForEach(0..<teams.count, id: \.self, content: { index in
                        Text(teams[index].name).tag(index)
                    })
                }.pickerStyle(WheelPickerStyle()).frame(width:300)
                Button("Edit Team") {
                    showEditTeamModal = true
                    print(teams)
                    print(selectedTeamIndex)
                }.sheet(isPresented: $showEditTeamModal) {
                    AddTeamModal(team: teams[selectedTeamIndex], callback: edit)
                }
            }
            Button("Add Team") {
                showAddTeamModal = true
            }.sheet(isPresented: $showAddTeamModal) {
                AddTeamModal(callback: add)
            }
            Button("Submit") {
                callback(teams)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
    
    func add(team: Team) {
        teams.append(team)
    }
    
    func edit(team: Team) {
        teams[selectedTeamIndex] = team
    }
}
