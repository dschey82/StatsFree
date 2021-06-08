import SwiftUI

let TEST_URL: String = "vXK0CL3vFZU"

enum TeamLoc {
    case home, away
}

struct StatsCollectorView: View {
    @Environment(\.presentationMode) var presentation
    let game: Game
    @State private var YTWindow = YTWrapper()
    @State private var showHomeLineupModal = false
    @State private var showAwayLineupModal = false
    @State private var showHomeShotsModal = false
    @State private var showAwayShotsModal = false
    @State private var showStatsReportModal = false
    private let _statsCollector: StatsCollectorVM
    
    init(game: Game) {
        self.game = game
        _statsCollector = StatsCollectorVM(game: game)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Home")
                Button("Line Change") {
                    self.showHomeLineupModal = true
                    YTWindow.pause()
                }.padding().sheet(isPresented: $showHomeLineupModal, onDismiss: {YTWindow.play()}) {
                    LineupModal(statsVM: _statsCollector, home: .home, ytWindow: YTWindow )
                }
                Button("Shot Taken") {
                    self.showHomeShotsModal = true
                    YTWindow.pause()
                }.padding().sheet(isPresented: $showHomeShotsModal, onDismiss: {YTWindow.play()}) {
                    ShotsModalView(statsVM: _statsCollector, team: .home, ytWindow: YTWindow )
                }
            }
            HStack {
                Text("Away")
                Button("Line Change") {
                    self.showAwayLineupModal = true
                    YTWindow.pause()
                }.padding().sheet(isPresented: $showAwayLineupModal, onDismiss: {YTWindow.play()}) {
                    LineupModal(statsVM: _statsCollector, home: .away, ytWindow: YTWindow)
                }
                Button("Shot Taken") {
                    self.showAwayShotsModal = true
                    YTWindow.pause()
                }.padding().sheet(isPresented: $showAwayShotsModal, onDismiss: {YTWindow.play()}) {
                    ShotsModalView(statsVM: _statsCollector, team: .away, ytWindow: YTWindow )
                }
                Button("Game Finished") {
                    self.showStatsReportModal = true
                }.padding().sheet(isPresented: $showStatsReportModal, onDismiss: {}) {
                    StatsReportModal(statsVM: self._statsCollector)
                }
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
}

struct StatsCollectorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatsCollectorView(game: Game(videoId: TEST_URL, home: Team(name:"Traitors", roster:Roster(player_list: [])), away: Team(name:"Marauders", roster: Roster(player_list: []))))
        }
    }
}
