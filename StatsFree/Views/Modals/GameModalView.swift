import SwiftUI

let teams = [Team(name:"Traitors", roster:Roster(player_list: [])),
             Team(name:"Marauders", roster:Roster(player_list: [])),
             Team(name:"Bears", roster:Roster(player_list: []))]

struct GameModalView: View {
    @Environment(\.presentationMode) var presentation
    @State private var selectedDate: Date = Date()
    @State private var homeTeamIndex: Int = 0
    @State private var awayTeamIndex: Int = 1
    let callback: (Team, Team, Date) -> Void
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    // Home Team selector
                    Picker("Home Team", selection: $homeTeamIndex) {
                        ForEach (0 ..< teams.count) {
                            Text(teams[$0].name)
                        }
                    }
                    // Lineup selector
                    
                    // Substitute player add
                }
                VStack {
                    // Away Team Selector
                    Picker("Away Team", selection: $awayTeamIndex) {
                        ForEach (0 ..< teams.count) {
                            Text(teams[$0].name)
                        }
                    }
                    // Lineup Selector
                    
                    // Substitute player add
                }
                // Date Selector
                DatePicker("", selection: $selectedDate)
            }
            Button("Submit") {
                callback(teams[homeTeamIndex], teams[awayTeamIndex], selectedDate)
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}
