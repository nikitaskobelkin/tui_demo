import XCTest
import Combine
@testable import TUI

final class WelcomeViewModelTests: XCTestCase {
    private var viewModel: WelcomeViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        InjectedValues[\.networkService] = MockNetworkService(
            session: FakeSession(response: TestConstants.mockJSON)
        )
        InjectedValues[\.locationManager] = MockLocationManager(TestConstants.currentLocation)
        viewModel = WelcomeViewModel()
        cancellables = .init()
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: - Test Fetch Data with Location

    func testFetchDataWithLocation() {
        InjectedValues[\.locationManager] = MockLocationManager(TestConstants.currentLocation)
        viewModel.fetchData()
        XCTAssertTrue(viewModel.isLoading)
        let fromExpectation = expectation(description: "From")
        let toExpectation = expectation(description: "To")
        let citiesExpectation = expectation(description: "Cities")
        viewModel.$from
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertEqual(value, TestConstants.currentLocation)
                fromExpectation.fulfill()
            })
            .store(in: &cancellables)
        viewModel.$to
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertFalse(value.isEmpty)
                toExpectation.fulfill()
            })
            .store(in: &cancellables)
        viewModel.$cities
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertEqual(value.count, TestConstants.mockConnectionsQuantity)
                citiesExpectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 3.0)
    }

    // MARK: - Test Fetch Data without Location

    func testFetchDataWithoutLocation() {
        InjectedValues[\.locationManager] = MockLocationManager("")
        viewModel.fetchData()
        XCTAssertTrue(viewModel.isLoading)
        let fromExpectation = expectation(description: "From")
        let toExpectation = expectation(description: "To")
        let citiesExpectation = expectation(description: "Cities")
        viewModel.$from
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertFalse(value.isEmpty)
                fromExpectation.fulfill()
            })
            .store(in: &cancellables)
        viewModel.$to
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertFalse(value.isEmpty)
                toExpectation.fulfill()
            })
            .store(in: &cancellables)
        viewModel.$cities
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertEqual(value.count, TestConstants.mockConnectionsQuantity)
                citiesExpectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 3.0)
    }

    // MARK: - Test Swap Locations

    func testSwapLocations() {
        let from = "Porto"
        let to = "London"
        viewModel.from = from
        viewModel.to = to
        viewModel.swap()
        let fromExpectation = expectation(description: "From")
        let toExpectation = expectation(description: "To")
        viewModel.$from
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { value in
                XCTAssertEqual(value, to)
                fromExpectation.fulfill()
            })
            .store(in: &cancellables)
        viewModel.$to
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { value in
                XCTAssertEqual(value, from)
                toExpectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 3.0)
    }

    // MARK: - Test Find Cheapest Route

    func testFindCheapest() {
        viewModel.from = TestConstants.cheapest.from
        viewModel.to = TestConstants.cheapest.to
        viewModel.findCheapest()
        XCTAssertTrue(viewModel.isLoading)
        let showResultExpectation = expectation(description: "Show result")
        let cheapestExpectation = expectation(description: "Cheapest")
        viewModel.$shouldShowResult
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertTrue(value)
                showResultExpectation.fulfill()
            })
            .store(in: &cancellables)
        viewModel.$cheapest
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertEqual(value?.price, TestConstants.cheapest.price)
                cheapestExpectation.fulfill()
            })
            .store(in: &cancellables)
        waitForExpectations(timeout: 3.0)
    }
}
