import Foundation

struct Player : Hashable, Identifiable, Codable {
    internal init(id: UUID, given_name: String, family_name: String, jersey_number: String) {
        self.id = id
        self.given_name = given_name
        self.family_name = family_name
        self.jersey_number = jersey_number
    }
    
    internal init(given_name: String, family_name: String, jersey_number: String) {
        self.id = UUID()
        self.given_name = given_name
        self.family_name = family_name
        self.jersey_number = jersey_number
    }
    
    let id: UUID
    let given_name: String
    let family_name: String
    let jersey_number: String
}
