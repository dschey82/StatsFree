import SwiftUI

struct LineupModal: View {
    @Environment(\.presentationMode) var presentation
    private let home: TeamLoc
    private let statsVM: StatsCollectorVM
    private let _vm: LineupModalVM
    
    init(statsVM: StatsCollectorVM, home: TeamLoc, ytWindow: YTWrapper) {
        self.home = home
        self.statsVM = statsVM
        self._vm = LineupModalVM(initial: statsVM.getOnIceRoster(team: home), ytWindow: ytWindow)
    }
    
    func getBinding(key: UUID) -> Binding<Bool> {
        return Binding(get: {
            return self._vm.getIsOnIce(playerId: key, team: self.home)
        }, set: { isOn in
            self._vm.setIsOnIce(playerId: key, team: self.home, isOn: isOn)
        })
    }
    
    var body: some View {
        VStack {
            Spacer()
            List {
                let roster = statsVM.getRoster(team: self.home)
                ForEach(0..<roster.count) {
                    let player = roster[$0]
                    Toggle("\(player.jersey_number) \(player.given_name) \(player.family_name)", isOn: getBinding(key: player.id))
                        .toggleStyle(SwitchToggleStyle())
                }
            }
            HStack {
                Button("Cancel") {
                    self.presentation.wrappedValue.dismiss()
                }
                Spacer()
                Button("Submit") {
                    self.statsVM.updateOnIceRoster(active: _vm.getOnIceRoster(), team: self.home, timestamp: self._vm.videoTime)
                    self.presentation.wrappedValue.dismiss()
                }
            }.padding()
            Spacer()
        }
    }
}

struct LineupModal_Previews: PreviewProvider {
    static var previews: some View {
        Text("i don't know how to make mock previews")
    }
}
