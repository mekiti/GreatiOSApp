import SwiftUI

struct ServerListCell: View {
    let server: String
    let distance: String

    var body: some View {
        HStack {
            Text(server)
            Spacer()
            Text(distance)
        }
    }
}
