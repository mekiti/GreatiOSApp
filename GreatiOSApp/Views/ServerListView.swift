import SwiftUI
import Observation

struct ServerListView: View {
    @State var viewModel: ServerListViewModel

    @State private var showingAlert = false
    @State private var sort = SortBy.none

    private var sortedServers: [Server] {
        switch sort {
        case .name:
            return viewModel.servers.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .distance:
            return viewModel.servers.sorted { $0.distance < $1.distance }
        case .none:
            return viewModel.servers
        }
    }

    var body: some View {
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

#Preview {
    ServerListView(
        viewModel: ServerListViewModel(
            serversService: ServersService(
                repository: ServerRepositoryImpl()
            )
        )
    )
}
