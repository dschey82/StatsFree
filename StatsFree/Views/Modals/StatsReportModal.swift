import SwiftUI

struct StatsReportModal: View {
    private let _statsVM: StatsCollectorVM
    
    init(statsVM: StatsCollectorVM) {
        self._statsVM = statsVM
    }
    
    var timeOnIceHome: [Player:Int] {
        return _statsVM.getTimeOnIceStats(team: .home)
    }
    
    var timeOnIceAway: [Player:Int] {
        return _statsVM.getTimeOnIceStats(team: .away)
    }
    
    var body: some View {
        HStack {
            Text("Player Jersey")
            Text("Time on Ice")
        }
        List(timeOnIceHome.sorted(by: { a,b in
            a.value > b.value
        }), id: \.key) { entry in
            HStack {
                Text("\(entry.key.jersey_number) \(entry.key.given_name) \(entry.key.family_name)")
                Text("\(timeOnIceHome[entry.key]!) seconds")
            }
        }
    }
}

struct StatsReportModal_Previews: PreviewProvider {
    static var previews: some View {
        Text("still nope")
    }
}
