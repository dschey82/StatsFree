import SwiftUI

let TEST_URL: String = "vXK0CL3vFZU"

struct ContentView: View {
    @State private var youtubeUrl: String = TEST_URL
    @State private var userEnteredValue: String = ""
    @State private var YTWindow = YTWrapper()
    @State private var showModal = false

    var body: some View {
        VStack {
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
                }
                Button(action: play) { Text("Play")}.background(Color.gray).foregroundColor(.white)
            }.padding().sheet(isPresented: $showModal, onDismiss: {YTWindow.play()}) {
                ShotsModalView()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
