import Foundation
import SwiftData

@Model
class Server: Identifiable, Decodable {
    var name: String
    var distance: Int

    enum CodingKeys: String, CodingKey {
        case name, distance
    }

    init(name: String, distance: Int) {
        self.name = name
        self.distance = distance
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        distance = try container.decode(Int.self, forKey: .distance)
    }
}

extension Server {
    var distanceString: String {
        "\(distance) km"
    }
}
