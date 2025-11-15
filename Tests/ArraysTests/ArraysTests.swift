import XCTest
@testable import Arrays

final class ArraysTests: XCTestCase {
    // MARK: Initialization tests
    
    func test_init_createsEmptyArray() {
        let dynamicArray = DynamicArray<Int>()
        XCTAssertEqual(dynamicArray.count, 0, "Newly initialized DynamicArray should have count 0")
        XCTAssertEqual(dynamicArray.isEmpty, true, "Newly initialized DynamicArray should be empty")
    }
    
    func test_initWithArrayLiteral_initializesCorrectly() {
        let arrayLiteral: DynamicArray<Int> = [1, 2, 3, 4, 5]
        XCTAssertEqual(arrayLiteral.count, 5, "DynamicArray initialized with array literal should have correct count")
        for i in 0..<arrayLiteral.count {
            XCTAssertEqual(arrayLiteral[i], i + 1, "Element at index \(i) should be \(i + 1)")
        }
    }
    
    // MARK: Append tests
    
    func test_appendSingleElement_increasesCount() {
        var array = DynamicArray<Int>()
        
        array.append(0)
        
        XCTAssertEqual(array.count, 1)
    }
    
    func test_appendMultipleElements_appendsInCorrectOrder() {
        var array = DynamicArray<Int>()
        
        array.append(0)
        array.append(1)
        array.append(2)
        
        XCTAssertEqual(array[0], 0)
        XCTAssertEqual(array[1], 1)
        XCTAssertEqual(array[2], 2)
    }
    
    func test_append_triggersResizeWhenFull() {
        var array = DynamicArray<Int>()
        
        for i in 0..<10 {
            array.append(i)
        }
        
        XCTAssertEqual(array.count, 10)
    }
    
    func test_appendAfterResize_elementsAreCorrect() {
        var array = DynamicArray<Int>()
        
        for i in 0..<10 {
            array.append(i)
        }
        
        for i in 0..<10 {
            XCTAssertEqual(array[i], i)
        }
    }
    
    func test_appendDuplicates_worksCorrectly() {
        var array = DynamicArray<Int>()
        
        array.append(1)
        array.append(1)
        array.append(2)
        array.append(2)
        
        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(array[0], 1)
        XCTAssertEqual(array[1], 1)
        XCTAssertEqual(array[2], 2)
        XCTAssertEqual(array[3], 2)
    }
    
    func test_appendManyTimes_isStable() {
        var array = DynamicArray<Int>()
        
        for i in 0..<10_000 {
            array.append(i)
        }
        
        XCTAssertEqual(array.count, 10_000)
        
        for i in 0..<10_000 {
            XCTAssertEqual(array[i], i)
        }
    }
    
    // MARK: Insert tests
    
    func test_insertAtBeginning_shiftsElementsRight() {
        var array: DynamicArray<Int> = [1, 2, 3]
        
        array.insert(0, at: 0)
        
        for i in 0..<array.count {
            XCTAssertEqual(array[i], i)
        }
    }
    
    func test_insertAtMiddle_shiftsCorrectElements() {
        var array: DynamicArray<Int> = [1, 2, 4, 5]
        
        array.insert(3, at: 2)
        
        for i in 0..<array.count {
            XCTAssertEqual(array[i], i + 1)
        }
    }
    
    func test_insertAtEnd_appendsEquivalent() {
        var array: DynamicArray<Int> = [1, 2, 3]
        
        array.insert(4, at: array.count)
        
        XCTAssertEqual(array[array.count - 1], 4)
    }
    
    func test_insertIntoEmptyArray_atIndexZero() {
        var array = DynamicArray<Int>()
        
        array.insert(42, at: 0)
        
        XCTAssertEqual(array.count, 1)
        XCTAssertEqual(array[0], 42)
    }
    
    // MARK: Subscript tests
    
    func test_subscriptGet_validIndex_retrievesElement() {
        let array: DynamicArray<Int> = [10, 20, 30]
        
        XCTAssertEqual(array[0], 10)
        XCTAssertEqual(array[1], 20)
        XCTAssertEqual(array[2], 30)
    }
    
    func test_subscriptSet_validIndex_updatesElement() {
        var array: DynamicArray<Int> = [10, 20, 30]
        
        array[1] = 99
        
        XCTAssertEqual(array[1], 99)
    }
    
    // MARK: Remove tests
    
    func test_removeFirstElement_shiftsDown() {
        var array: DynamicArray<Int> = [1, 2, 3]
        
        array.remove(at: 0)
        
        XCTAssertEqual(array.count, 2)
        XCTAssertEqual(array[0], 2)
        XCTAssertEqual(array[1], 3)
    }
    
    func test_removeMiddleElement_shiftsCorrectElements() {
        var array: DynamicArray<Int> = [1, 2, 3, 4, 5]
        
        array.remove(at: 2)
        
        XCTAssertEqual(array.count, 4)
        XCTAssertEqual(array[0], 1)
        XCTAssertEqual(array[1], 2)
        XCTAssertEqual(array[2], 4)
        XCTAssertEqual(array[3], 5)
    }
    
    func test_removeLastElement_decreasesCount() {
        var array: DynamicArray<Int> = [1, 2, 3]
        
        array.remove(at: 2)
        
        XCTAssertEqual(array.count, 2)
    }
    
    func test_removeSingleElementArray_resultsInEmptyArray() {
        var array: DynamicArray<Int> = [1]
        
        array.remove(at: 0)
        
        XCTAssertEqual(array.count, 0)
    }
    
    func test_remove_returnsRemovedElement() {
        var array: DynamicArray<Int> = [10, 20, 30]
        
        let removed = array.remove(at: 1)
        
        XCTAssertEqual(removed, 20)
    }
    
    // MARK: Contains tests
    
    func test_containsExistingElement_returnsTrue() {
        let array: DynamicArray<Int> = [1, 2, 3, 4, 6]
        
        XCTAssertTrue(array.contains(1))
        XCTAssertTrue(array.contains(3))
        XCTAssertTrue(array.contains(6))
    }
    
    func test_containsNonExistingElement_returnsFalse() {
        let array: DynamicArray<Int> = [1, 2, 3, 4, 5]
        
        XCTAssertFalse(array.contains(0))
        XCTAssertFalse(array.contains(-1))
    }
    
    func test_containsWithDuplicates_returnsTrue() {
        let array: DynamicArray<Int> = [1, 2, 2, 3, 4]
        
        XCTAssertTrue(array.contains(2))
    }
        
    // MARK: FirstIndex tests
    
    func test_firstIndexForExistingElement_returnsCorrectIndex() {
        let array: DynamicArray<Int> = [10, 20, 30, 20, 40]
        
        XCTAssertEqual(array.firstIndex(of: 10), 0)
        XCTAssertEqual(array.firstIndex(of: 20), 1)
        XCTAssertEqual(array.firstIndex(of: 30), 2)
        XCTAssertEqual(array.firstIndex(of: 40), 4)
    }
    
    func test_firstIndexForNonExistingElement_returnsNil() {
        let array: DynamicArray<Int> = [10, 20, 30]
        
        XCTAssertNil(array.firstIndex(of: 99))
        XCTAssertNil(array.firstIndex(of: -1))
    }
    
    func test_firstIndexForDuplicateElements_returnsFirstIndex() {
        let array: DynamicArray<Int> = [5, 10, 5, 20, 5]
        
        XCTAssertEqual(array.firstIndex(of: 5), 0)
    }
    
    func test_firstIndexForEmptyArray_returnsNil() {
        let array: DynamicArray<Int> = []
        
        XCTAssertNil(array.firstIndex(of: 1))
    }
    
    // MARK: Clear tests
    
    func test_clear_emptiesArray() {
        let array: DynamicArray<Int> = [1, 2, 3, 4, 5]
        
        array.clear()
        
        XCTAssertEqual(array.count, 0)
        XCTAssertEqual(array.isEmpty, true)
    }
    
    func test_clearThenAppend_worksCorrectly() {
        var array: DynamicArray<Int> = [1, 2, 3]
        
        array.clear()
        array.append(42)
        
        XCTAssertEqual(array.count, 1)
        XCTAssertEqual(array[0], 42)
    }
    
}
