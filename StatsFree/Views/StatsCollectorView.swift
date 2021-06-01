import SwiftUI

let TEST_URL: String = "vXK0CL3vFZU"

struct StatsCollectorView: View {
    let game: Game
    @State private var statEvents = [StatEvent]()
    @State private var YTWindow = YTWrapper()
    @State private var showHomeShotsModal = false
    @State private var showAwayShotsModal = false
    
    init(game: Game) {
        self.game = game
    }
    var body: some View {
        VStack {
            HStack {
                Text("Home")
                Button("Shot Taken") {
                    self.showHomeShotsModal = true
                    YTWindow.pause()
                }.padding().sheet(isPresented: $showHomeShotsModal, onDismiss: {YTWindow.play()}) {
                    ShotsModalView(game: game, homeTeam: true, timestamp: YTWindow.getTime(), callback: addStat)
                }
                Button(action: play) { Text("Play")}.background(Color.gray).foregroundColor(.white)
            }
            HStack {
                Text("Away")
                Button("Shot Taken") {
                    self.showAwayShotsModal = true
                    YTWindow.pause()
                }.padding().sheet(isPresented: $showAwayShotsModal, onDismiss: {YTWindow.play()}) {
                    ShotsModalView(game: self.game, homeTeam: false, timestamp: YTWindow.getTime(), callback: addStat)
                }
                Button(action: play) { Text("Play")}.background(Color.gray).foregroundColor(.white)
            }
            YTWindow
        }.onAppear(perform: loadDefaults)
    }
    
    func loadDefaults() {
        YTWindow.loadVideo(videoId: game.videoId)
    }
    
    func update() {
        
    }
    
    func pause() {
        YTWindow.pause()
    }
    
    func play() {
        YTWindow.play()
    }
    
    func validate(val: String) -> Bool {
        return true;
    }
    
    func addStat(event: StatEvent) {
        print(event)
        statEvents.append(event)
    }
}

struct StatsCollectorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatsCollectorView(game: Game(videoId: TEST_URL, home: Team(name:"Traitors", roster:Roster(player_list: [])), away: Team(name:"Marauders", roster: Roster(player_list: []))))
        }
    }
}
