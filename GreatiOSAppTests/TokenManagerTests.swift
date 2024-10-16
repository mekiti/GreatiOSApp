import Testing
import Foundation

struct TokenManagerTests {
    let testToken = "Token123"
    @Test("Save token") func testSortedServersByName() async {
        let tokenManager = await TokenManager()
        await tokenManager.update(token: testToken)

        await #expect(tokenManager.getToken() == testToken)
    }

    @Test("Delete token") func testSortedServersByDistance() async {
        let tokenManager = await TokenManager()
        await tokenManager.clear()

        await #expect(tokenManager.getToken() == nil)
    }
}
