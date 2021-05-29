import SwiftUI

let TEST_URL: String = "vXK0CL3vFZU"

struct StatsCollectorView: View {
    @State private var youtubeUrl: String = TEST_URL
    @State private var userEnteredValue: String = ""
    @State private var YTWindow = YTWrapper()
    @State private var showModal = false
    @State private var game: Game?
    @State private var showGameModal = false

    var body: some View {
        VStack {
            HStack {
                if (game == nil){
                    Button("Enter Game Info") {
                        showGameModal = true
                        YTWindow.pause()
                    }.sheet(isPresented: $showGameModal, onDismiss: {YTWindow.play()}) {
                        GameModalView(callback: setActiveGame)
                    }
                }
            }
            HStack {
                Text("YouTube URL: ")
                TextField("" , text: $userEnteredValue)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color(UIColor.separator))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: update) { Text("Open") }.background(Color.gray).foregroundColor(.white)
            }.padding()
            HStack {
                Button("Shot Taken") {
                    self.showModal = true
                    YTWindow.pause()
                }.padding().sheet(isPresented: $showModal, onDismiss: {YTWindow.play()}) {
                    ShotsModalView()
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
    
    func setActiveGame(home: Team, away: Team, date: Date) {
        game = Game(home: home, away: away)
    }
}

struct StatsCollectorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatsCollectorView()
        }
    }
}
