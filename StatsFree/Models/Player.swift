import Foundation

struct Player : Hashable, Identifiable {
    let id = UUID()
    
    let given_name: String
    let family_name: String
    let jersey_number: Int
}
