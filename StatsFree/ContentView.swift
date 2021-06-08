import SwiftUI

private let TEAMS_FILE = "teams.json"
private let GAMES_FILE = "games.json"

struct ContentView: View {
    @State private var showGameModal = false;
    @State private var showTeamModal = false;
    @State private var activeGame: Game?
    @State private var test: String = ""
    private var games: [Game] = []
    private let fileManager: FileManager = .default
    
    var body: some View {
        if (activeGame == nil) {
            VStack {
                Spacer()
                NavigationView {
                    NavigationLink(destination: ManageTeamsView(teams: getTeams(), callback: addTeams)) {
                        Text("Manage Teams")
                    }
                }
                
                Text("\(test)")
                Button("Open New Game") {
                    showGameModal = true
                }.sheet(isPresented: $showGameModal) {
                    GameModalView(teams: getTeams(), callback: setActiveGame)
                }
            }
            Spacer()
        } else {
            StatsCollectorView(game: activeGame!)
        }
    }
    
    func addTeams(_ teams: [Team]){
        var existing = getTeams()
        for index in 0..<teams.count {
            var exists = false
            for eindex in 0..<existing.count {
                if teams[index].id == existing[eindex].id {
                    exists = true
                    existing[index] = teams[index]
                }
            }
            if !exists {
                existing.append(teams[index])
            }
        }
        saveTeams(teams: existing)
    }
    
    func saveTeams(teams: [Team]) {
        let docUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let path = docUrl.appendingPathComponent(TEAMS_FILE)
        
        guard let toWrite = encode(teams) else {
            return
        }
        do {
            try toWrite.write(to: path, atomically: true, encoding: .utf8)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func encode(_ teams: [Team]) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(teams)
            return String(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    func getTeams()-> [Team] {
        let docUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let path = docUrl.appendingPathComponent(TEAMS_FILE)
        do {
            let stringer = try String(contentsOf: path)
            let json = stringer.data(using: .utf8)!
            let decoder = JSONDecoder()
            let data = try decoder.decode([Team].self, from: json)
            return data
        } catch {
            print(error.localizedDescription)
            return [Team]()
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
