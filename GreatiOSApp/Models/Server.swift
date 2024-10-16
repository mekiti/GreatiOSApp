import Foundation

struct Server: Identifiable, Decodable {
    var id = UUID()

    let name: String
    let distance: Int

    enum CodingKeys: String, CodingKey {
        case name, distance
    }
}

extension Server {
    var distanceString: String {
        "\(distance) km"
    }
}
