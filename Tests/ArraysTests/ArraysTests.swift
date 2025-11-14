import XCTest
@testable import Arrays

final class ArraysTests: XCTestCase {
    func testAppendAndSubscriptAccess() {
        var array = DynamicArray<Int>()

        array.append(1)
        array.append(2)
        array.append(3)

        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array[0], 1)
        XCTAssertEqual(array[1], 2)
        XCTAssertEqual(array[2], 3)
    }

    func testInsertUpdatesOrder() {
        var array = DynamicArray(arrayLiteral: 1, 2, 4)

        array.insert(3, at: 2)

        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(array[0], 1)
        XCTAssertEqual(array[1], 2)
        XCTAssertEqual(array[2], 3)
        XCTAssertEqual(array[3], 4)
    }
}
