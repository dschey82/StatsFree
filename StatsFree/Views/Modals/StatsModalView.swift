import SwiftUI

struct StatsModalView: View {
    @Environment(\.presentationMode) var presentation
    let message: String

    var body: some View {
        VStack {
            Text(message)
            Button("Submit") {
                
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}
