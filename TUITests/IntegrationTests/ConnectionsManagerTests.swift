import XCTest
import Combine
@testable import TUI

final class ConnectionsManagerTests: XCTestCase {
    private var manager: ConnectionsManagerProtocol!

    override func setUp() {
        super.setUp()
        manager = ConnectionsManager()
    }

    override func tearDown() {
        manager = nil
        super.tearDown()
    }

    // MARK: - Successful Fetch

    func testFetchConnectionsSuccessful() async {
        InjectedValues[\.networkService] = MockNetworkService(
            session: FakeSession(
                response: TestConstants.mockJSON
            )
        )
        let expectation = XCTestExpectation(description: "Fetch")
        let response = await manager.fetchConnections()
        expectation.fulfill()
        switch response {
        case .success(let data):
            XCTAssertEqual(data.connections.count, TestConstants.mockConnectionsQuantity)
        default:
            XCTFail(TestConstants.TestError.failureConnection.rawValue)
        }
        await fulfillment(of: [expectation], timeout: 3.0)
    }

    // MARK: - Failure Fetch

    func testFetchConnectionsFailure() async {
        InjectedValues[\.networkService] = MockNetworkService(
            session: FakeSession(
                error: .badRequest
            )
        )
        let expectation = XCTestExpectation(description: "Fetch")
        let response = await manager.fetchConnections()
        expectation.fulfill()
        switch response {
        case .failure(let error):
            switch error {
            case .badRequest:
                break
            default:
                XCTFail(TestConstants.TestError.failureConnection.rawValue)
            }
        default:
            XCTFail(TestConstants.TestError.failureConnection.rawValue)
        }
        await fulfillment(of: [expectation], timeout: 3.0)
    }
}
