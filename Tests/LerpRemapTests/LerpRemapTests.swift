import XCTest
@testable import LerpRemap

final class LerpRemapTests: XCTestCase {

    func testLerp() {
        XCTAssertEqual(-0.5.lerp(min: 0, max: 10), -5)
        XCTAssertEqual(0.5.lerp(min: 0, max: 10), 5)
        XCTAssertEqual(1.5.lerp(min: 0, max: 10), 15)
        XCTAssertEqual(1.5.lerp(min: 0, max: 10).clamped(min: 0, max: 10), 10)
        XCTAssertEqual(1.5.lerp(min: 10, max: 0).clamped(min: 10, max: 0), 0)
    }

    func testInvLerp() {
        XCTAssertEqual(-5.invLerp(min: 0, max: 10), -0.5)
        XCTAssertEqual(5.invLerp(min: 0, max: 10), 0.5)
        XCTAssertEqual(15.invLerp(min: 0, max: 10), 1.5)
    }

    func testRemap() {
        XCTAssertEqual(0.5.remap(fromMin: 0, fromMax: 1, toMin: 0, toMax: 10), 5)
        XCTAssertEqual(30.remap(fromMin: 0, fromMax: 100, toMin: 0, toMax: 1), 0.3)
    }

    func testClamped() {
        XCTAssertEqual(
            1.clamped(min: 0, max: 10),
            1
        )
        XCTAssertEqual(
            1.clamped(min: 5, max: 10),
            5
        )
        XCTAssertEqual(
            1.clamped(min: 4, max: 0),
            1
        )
        XCTAssertEqual(
            1.clamped(min: -5, max: 0),
            0
        )
    }

    func testTypeSystem() {
        let float: Float = 0
        let cgfloat: CGFloat = 0
        let double: Double = 0

        _ = float.clamped(min: 1, max: 2)
        _ = cgfloat.clamped(min: 1, max: 2)
        _ = double.clamped(min: 1, max: 2)

        // Checking if it compiles
    }
}
