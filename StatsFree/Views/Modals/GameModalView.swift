import SwiftUI

struct GameModalView: View {
    @Environment(\.presentationMode) var presentation
    @State private var selectedDate: Date = Date()
    @State private var homeTeamIndex: Int = 0
    @State private var awayTeamIndex: Int = 1
    @State private var ytUrl = ""
    let teams: [Team]
    let callback: (String, Team, Team, Date) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("YouTube URL: ")
                TextField("" , text: $ytUrl)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color(UIColor.separator))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                // Home Team selector
                Text("Home Team")
                Picker("Home Team", selection: $homeTeamIndex) {
                    ForEach (0 ..< teams.count) {
                        Text(teams[$0].name)
                    }
                }.pickerStyle(WheelPickerStyle()).frame(width:300)
            }.frame(height:150)
            
            HStack {
                // Away Team Selector
                Text("Away Team")
                Picker("Away Team", selection: $awayTeamIndex) {
                    ForEach (0 ..< teams.count) {
                        Text(teams[$0].name)
                    }
                }.pickerStyle(WheelPickerStyle()).frame(width:300)
                // Lineup Selector
                
                // Substitute player add
            }.frame(height:150)
            
            // Date Selector
            HStack {
                Spacer()
                Text("Game Day:")
                DatePicker("", selection: $selectedDate).frame(width:100, alignment:.leading)
                Spacer()
            }
            Spacer()
            HStack {
                Button("Cancel") {
                    self.presentation.wrappedValue.dismiss()
                }
                Spacer()
                Button("Submit") {
                    // TODO: Data validation
                    callback(ytUrl, teams[homeTeamIndex], teams[awayTeamIndex], selectedDate)
                    self.presentation.wrappedValue.dismiss()
                }
            }.padding()
            Spacer()
        }
    }
}

struct GameModalView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Don't Preview This!")
    }
}
