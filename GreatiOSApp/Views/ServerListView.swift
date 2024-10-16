import SwiftUI
import Observation

struct ServerListView: View {
    @State var viewModel: ServerListViewModel

    var body: some View {
        List {
            Section {
                ForEach(viewModel.sortedServers) { server in
                    ServerListCell(server: server.name, distance: server.distanceString)
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
                    viewModel.showingAlert = true
                } label: {
                    HStack {
                        Image(.sortIcon)
                        Text(Constants.filterString)
                    }
                }
                .confirmationDialog("", isPresented: $viewModel.showingAlert, titleVisibility: .hidden) {
                    Button(Constants.sortByDistanceString) {
                        viewModel.sort = .distance
                    }

                    Button(Constants.sortAlphabeticallyString) {
                        viewModel.sort = .name
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
    ServerListView(viewModel: ServerListViewModel(servers: []))
}
