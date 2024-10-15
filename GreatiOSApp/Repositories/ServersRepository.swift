protocol ServersRepository {
    func getServers() -> [Server]
}

class ServerRepositoryImpl: ServersRepository {
    func getServers() -> [Server] {
        return [
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
    }
}
