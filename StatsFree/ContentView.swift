import SwiftUI

private let TEAMS_FILE = "teams.json"
private let GAMES_FILE = "games.json"

struct ContentView: View {
    @State private var showGameModal = false;
    @State private var showTeamModal = false;
    @State private var activeGame: Game?
    @State private var teams: [Team] = [Team]()
    @State private var test: String = ""
    private var games: [Game] = []
    private let fileManager: FileManager = .default
    
    var body: some View {
        if (activeGame == nil) {
            VStack {
                Spacer()
                Button("Manage Teams") {
                   showTeamModal = true
                }.sheet(isPresented: $showTeamModal) {
                    ManageTeamsView(teams: self.teams, callback: addTeams)
                }.frame(height:200)
                Text("\(test)")
                Button("Open New Game") {
                    showGameModal = true
                }.sheet(isPresented: $showGameModal) {
                    GameModalView(teams: teams, callback: setActiveGame)
                }
            }.onAppear(perform: getTeams)
            Spacer()
        } else {
            StatsCollectorView(game: activeGame!)
        }
    }
    
    func addTeams(_ teams: [Team]){
        for team in teams {
            guard let existing = self.teams.firstIndex(of: team) else {
                self.teams.append(team)
                continue
            }
            self.teams[existing] = team
        }
    }
    
    func addTeam(team: Team) {
        teams.append(team)
        saveTeams()
    }
    
    func saveTeams() {
        let docUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let path = docUrl.appendingPathComponent(TEAMS_FILE)
        let toWrite = "Valorant"
        do {
            try toWrite.write(to: path, atomically: true, encoding: .utf8)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getTeams()-> Void {
        let docUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let path = docUrl.appendingPathComponent(TEAMS_FILE)
        do {
            let todos = try String(contentsOf: path)

            for todo in todos.split(separator: ";") {
                print(todo)
            }
            
            test = todos;
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setActiveGame(videoId: String, home: Team, away: Team, date: Date) {
        activeGame = Game(videoId: videoId, home: home, away: away)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
