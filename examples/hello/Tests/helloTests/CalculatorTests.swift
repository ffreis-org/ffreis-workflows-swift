import XCTest
@testable import hello

final class CalculatorTests: XCTestCase {
    func testAdds() {
        XCTAssertEqual(Calculator.add(2, 3), 5)
    }

    func testMultiplies() {
        XCTAssertEqual(Calculator.multiply(2, 3), 6)
    }
}
