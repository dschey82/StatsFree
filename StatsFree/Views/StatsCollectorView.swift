import SwiftUI

let TEST_URL: String = "vXK0CL3vFZU"

struct StatsCollectorView: View {
    let game: Game
    // TODO: figure out why this needs to be marked @State to work
    @State private var statEvents = [StatEvent]()
    
    @State private var youtubeUrl: String = TEST_URL
    @State private var userEnteredValue: String = ""
    @State private var YTWindow = YTWrapper()
    @State private var showModal = false
    @State private var showGameModal = false
    
    init(game: Game) {
        self.game = game
    }
    var body: some View {
        VStack {
            HStack {
                Button("Shot Taken") {
                    self.showModal = true
                    YTWindow.pause()
                }.padding().sheet(isPresented: $showModal, onDismiss: {YTWindow.play()}) {
                    ShotsModalView(callback: addStat)
                }
                Button(action: play) { Text("Play")}.background(Color.gray).foregroundColor(.white)
            }
            YTWindow
        }.onAppear(perform: loadDefaults)
    }
    
    func loadDefaults() {
        YTWindow.loadVideo(videoId: TEST_URL)
    }
    
    func update() {
        if (validate(val: userEnteredValue)) {
            YTWindow.loadVideo(videoId: userEnteredValue)
        }
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
