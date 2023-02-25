import XCTest
@testable import RandomAnimalName

final class RandomAnimalNameTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertNotEqual(randomAnimalName(), "Happy Humunculous")
    }
}
