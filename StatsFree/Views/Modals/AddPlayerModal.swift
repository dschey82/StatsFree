import SwiftUI

struct AddPlayerModal: View {
    @Environment(\.presentationMode) var presentation
    @State private var family_name = ""
    @State private var given_name = ""
    @State private var jersey_number = ""
    let callback: (Player) -> Void
    
    var body: some View {
        VStack {
            TextField("Given Name" , text: $given_name)
                .autocapitalization(.words)
                .disableAutocorrection(true)
                .border(Color(UIColor.separator))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Family Name" , text: $family_name)
                .autocapitalization(.words)
                .disableAutocorrection(true)
                .border(Color(UIColor.separator))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Jersey Number" , text: $jersey_number)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .border(Color(UIColor.separator))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            HStack {
                Button("Cancel") {
                    self.presentation.wrappedValue.dismiss()
                }
                Spacer()
                Button("Add") {
                    // TODO: validate data
                    let jersey = Int(jersey_number)
                    callback(Player(given_name: given_name, family_name: family_name, jersey_number: jersey ?? -1))
                    self.presentation.wrappedValue.dismiss()
                }
            }.padding()
        }
    }
}
