import SwiftUI

struct ServerListView: View {
    let servers: [Server] = [
        .init(name: "Canada #10", distance: 400),
        .init(name: "Canada #10", distance: 500),
        .init(name: "Canada #10", distance: 4000),
        .init(name: "Canada #10", distance: 100),
        .init(name: "Canada #344", distance: 6000),
        .init(name: "bCanada #10", distance: 5500),
        .init(name: "Canada #10", distance: 2500),
        .init(name: "Canada #10", distance: 3000),
        .init(name: "dCanada #10", distance: 4509),
        .init(name: "Canada #10", distance: 4345),
        .init(name: "eCanada #10", distance: 1234),
        .init(name: "eCanada #10", distance: 3344),
        .init(name: "aCanada #10", distance: 1234),
        .init(name: "Canada #10", distance: 6643),
    ]

    @State private var showingAlert = false
    @State private var sort = SortBy.none

    private var sortedServers: [Server] {
        switch sort {
        case .name:
            return servers.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .distance:
            return servers.sorted { $0.distance < $1.distance }
        case .none:
            return servers
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(sortedServers) { server in
                        ServerListCell(server: server.name, distance: String(server.distance))
                    }
                } header: {
                    HStack {
                        Text(Constants.serverString.uppercased())
                            .font(.caption)
                        Spacer()
                        Text(Constants.distanceString.uppercased())
                            .font(.caption)
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle(Constants.titleString)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingAlert = true
                    } label: {
                        HStack {
                            Image(.sortIcon)
                            Text(Constants.filterString)
                        }
                    }
                    .confirmationDialog("", isPresented: $showingAlert, titleVisibility: .hidden) {
                        Button(Constants.sortByDistanceString) {
                            sort = .distance
                        }

                        Button(Constants.sortAlphabeticallyString) {
                            sort = .name
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                    } label: {
                        HStack {
                            Text(Constants.logoutString)
                            Image(.logoutIcon)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ServerListView()
}
