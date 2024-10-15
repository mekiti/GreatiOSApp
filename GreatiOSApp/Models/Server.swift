import Foundation

struct Server: Identifiable, Decodable {
    var id = UUID()

    let name: String
    let distance: Int
}
