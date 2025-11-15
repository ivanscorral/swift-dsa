//
//  LinkedListTests.swift
//  swift-dsa
//
//  Created by Ivan Sanchez Corral on 15/11/25.
//

import XCTest
@testable import LinkedList

final class LinkedListTests: XCTestCase {
    
    // MARK: Node tests

    func test_initNodeWithValue_setsValueCorrectly() {
        let node = Node(10)
        
        XCTAssertEqual(node.value, 10)
        XCTAssertNil(node.next)
    }
    
    // MARK: LinkedList tests
    
    func test_init_createsEmptyLinkedList() {
        let linkedList = LinkedList<Int>()
        
        XCTAssertNil(linkedList.head)
        XCTAssertNil(linkedList.tail)
        XCTAssertEqual(linkedList.count, 0)
    }
    
    // MARK: Append node tests
    
    func test_appendFirstNode_setsHeadAndTail() {
        let linkedList = LinkedList<Int>()
        let node = Node(5)
        
        linkedList.append(node)
        
        XCTAssertEqual(linkedList.head, node)
        XCTAssertEqual(linkedList.tail, node)
        XCTAssertEqual(linkedList.count, 1)
    }
    
    func test_appendMultipleNodes_updatesTailCorrectly() {
        let linkedList = LinkedList<Int>()
        let node1 = Node(1)
        let node2 = Node(2)
        
        linkedList.append(node1)
        linkedList.append(node2)
        
        XCTAssertEqual(linkedList.head, node1)
        XCTAssertEqual(linkedList.tail, node2)
    }
    
    func test_appendNode_preservesOrder() {
        let linkedList = LinkedList<Int>()
        let node1 = Node(1)
        let node2 = Node(2)
        let node3 = Node(3)
        
        linkedList.append(node1)
        linkedList.append(node2)
        linkedList.append(node3)
        
        XCTAssertEqual(linkedList.head?.value, 1)
        XCTAssertEqual(linkedList.head?.next?.value, 2)
        XCTAssertEqual(linkedList.head?.next?.next?.value, 3)
    }
    
    
    // MARK: Append value tests
    
    func test_appendSingleValue_createsHeadAndTail() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(5)
        
        XCTAssertEqual(linkedList.head?.value, 5)
        XCTAssertEqual(linkedList.tail?.value, 5)
        XCTAssertEqual(linkedList.count, 1)
        XCTAssertEqual(linkedList.head, linkedList.tail)
    }
    
    func test_appendMultipleValues_appendsInCorrectOrder() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        linkedList.append(2)
        linkedList.append(3)
        
        XCTAssertEqual(linkedList.head?.value, 1)
        XCTAssertEqual(linkedList.tail?.value, 3)
        XCTAssertEqual(linkedList.count, 3)
        
        XCTAssertEqual(linkedList.head?.next?.value, 2)
        XCTAssertEqual(linkedList.head?.next?.next?.value, 3)
    }
    
    func test_appendValue_updatesTail() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(10)
        XCTAssertEqual(linkedList.tail?.value, 10)
        
        linkedList.append(20)
        XCTAssertEqual(linkedList.tail?.value, 20)
    }
    
    // MARK: Prepend tests
    
    func test_prependValueOnEmptyList_setsHeadAndTail() {
        let linkedList = LinkedList<Int>()
        
        linkedList.prepend(10)
        
        XCTAssertEqual(linkedList.head?.value, 10)
        XCTAssertEqual(linkedList.tail?.value, 10)
    }
    
    func test_prependValue_addsToFront() {
        let linkedList = LinkedList<Int>()
        
        linkedList.prepend(10)
        XCTAssertEqual(linkedList.head?.value, 10)
        
        linkedList.prepend(20)
        XCTAssertEqual(linkedList.head?.value, 20)
        
        linkedList.prepend(30)
        XCTAssertEqual(linkedList.head?.value, 30)
        
        XCTAssertEqual(linkedList.count, 3)
        XCTAssertEqual(linkedList.tail?.value, 10)
    }
    
    func test_prependValue_preservesExistingLinks() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        let head = linkedList.head
        linkedList.prepend(0)
        
        XCTAssertEqual(head, linkedList.head?.next)
    }
    
    // MARK: Element at index tests
    
    func test_elementAtValidIndex_returnsValue() {
        let linkedList = LinkedList<Int>()
        
        for i in 0..<5 {
            linkedList.append(i)
        }
        
        XCTAssertEqual(linkedList.element(at: 0), 0)
        XCTAssertEqual(linkedList.element(at: 2), 2)
        XCTAssertEqual(linkedList.element(at: 4), 4)
    }
    
    func test_elementAtIndexZero_returnsHeadValue() {
        let linkedList = LinkedList<Int>()
        linkedList.append(10)
        
        XCTAssertEqual(linkedList.element(at: 0), linkedList.head?.value)
    }
    
    func test_elementAtLastIndex_returnsTailValue() {
        let linkedList = LinkedList<Int>()
        
        for i in 0..<3 {
            linkedList.append(i)
        }
        
        XCTAssertEqual(linkedList.element(at: linkedList.count - 1), linkedList.tail?.value)
    }
    
    func test_elementAtOutOfRangeIndex_returnsNil() {
        let linkedList = LinkedList<Int>()
        
        for i in 0..<3 {
            linkedList.append(i)
        }
        
        XCTAssertNil(linkedList.element(at: -1))
        XCTAssertNil(linkedList.element(at: 3))
        XCTAssertNil(linkedList.element(at: 10))
    }
    
    func test_elementAtOnEmptyList_returnsNil() {
        let linkedList = LinkedList<Int>()
        
        XCTAssertNil(linkedList.element(at: 0))
    }
    
    // MARK: Sequence conformance tests
    
    func test_iterationOverEmptyList_yieldsNoElements() {
        let linkedList = LinkedList<Int>()
        
        var count = 0
        
        for _ in linkedList {
            count += 1
        }
        
        XCTAssertEqual(count, 0)
    }
    
    func test_iteration_returnsElementsInOrder() {
        let linkedList = LinkedList<Int>()
        
        [1, 2, 3].forEach { linkedList.append($0) }
        
        for (element, expected) in zip(linkedList, [1, 2, 3]) {
            XCTAssertEqual(element, expected)
        }
    }
    
    func test_iteration_afterPrependAndAppend_returnsCorrectOrder() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(2)
        linkedList.prepend(1)
        linkedList.append(3)
        
        let expectedOrder = [1, 2, 3]
        var index = 0
        
        for element in linkedList {
            XCTAssertEqual(element, expectedOrder[index])
            index += 1
        }
    }
    
    // MARK: RemoveFirst tests
    
    func test_removeFirstOnEmptyList_returnsNil() {
        let linkedList = LinkedList<Int>()
        
        let removedElement = linkedList.removeFirst()
        
        XCTAssertNil(removedElement)
        XCTAssertEqual(linkedList.count, 0)
        XCTAssertNil(linkedList.head)
        XCTAssertNil(linkedList.tail)
    }
    
    func test_removeFirstOnSingleElementList_returnsCorrectAndEmptiesList() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(42)
        let removedElement = linkedList.removeFirst()
        
        XCTAssertEqual(removedElement, 42)
        XCTAssertEqual(linkedList.count, 0)
        XCTAssertEqual(linkedList.head, nil)
        XCTAssertEqual(linkedList.tail, nil)
    }
    
    func test_removeFirstOnMultipleElements_updatesHeadAndCount() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        linkedList.append(2)
        linkedList.append(3)
        
        let removedElement = linkedList.removeFirst()
        
        XCTAssertEqual(removedElement, 1)
        XCTAssertEqual(linkedList.count, 2)
        XCTAssertEqual(linkedList.head?.value, 2)
        XCTAssertEqual(linkedList.tail?.value, 3)
    }
    
    // MARK: Remove last tests
    
    func test_removeLastOnEmptyList_returnsNil() {
        let linkedList = LinkedList<Int>()
        
        let removedElement = linkedList.removeLast()
        
        XCTAssertNil(removedElement)
        XCTAssertEqual(linkedList.count, 0)
        XCTAssertNil(linkedList.head)
        XCTAssertNil(linkedList.tail)
    }
    
    func test_removeLastOnSingleElementList_returnsCorrectAndEmptiesList() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(42)
        let removedElement = linkedList.removeLast()
        
        XCTAssertEqual(removedElement, 42)
        XCTAssertEqual(linkedList.count, 0)
        XCTAssertEqual(linkedList.head, nil)
        XCTAssertEqual(linkedList.tail, nil)
    }
    
    func test_removeLastOnMultipleElements_updatesTailAndCount() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        linkedList.append(2)
        linkedList.append(3)
        
        let removedElement = linkedList.removeLast()
        
        XCTAssertEqual(removedElement, 3)
        XCTAssertEqual(linkedList.tail?.value, 2)
        XCTAssertEqual(linkedList.count, 2)
    }
    
    func test_removeLast_structureCorrectAfterSeveralOps() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        linkedList.append(2)
        linkedList.prepend(0)
        
        let removed = linkedList.removeLast()
        
        XCTAssertEqual(removed, 2)
        XCTAssertEqual(linkedList.head?.value, 0)
        XCTAssertEqual(linkedList.tail?.value, 1)
    }
    
    // MARK: RemoveAt tests
    
    func test_removeAtOnEmptyList_returnsNil() {
        let linkedList = LinkedList<Int>()
        
        let removedElement = linkedList.remove(at: 0)
        
        XCTAssertNil(removedElement)
        XCTAssertEqual(linkedList.count, 0)
    }
    
    func test_removeAtValidIndexZero_removesFirst() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        linkedList.append(2)
        linkedList.append(3)
        
        let removedElement = linkedList.remove(at: 0)
        
        XCTAssertEqual(removedElement, 1)
        XCTAssertEqual(linkedList.head?.value, 2)
        XCTAssertEqual(linkedList.count, 2)
    }
    
    func test_removeAtMiddleIndex_removesCorrectElement() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        linkedList.append(2)
        linkedList.append(3)
        linkedList.append(4)
        
        let removed = linkedList.remove(at: 2)
        
        XCTAssertEqual(removed, 3)
        for (i, value) in [1, 2, 4].enumerated() {
            XCTAssertEqual(linkedList.element(at: i), value)
        }
        XCTAssertEqual(linkedList.count, 3)
    }
    
    func test_removeAtLastIndex_removesLast() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        linkedList.append(2)
        linkedList.append(3)
        
        let removedElement = linkedList.remove(at: 2)
        
        XCTAssertEqual(removedElement, 3)
        XCTAssertEqual(linkedList.tail?.value, 2)
        XCTAssertEqual(linkedList.count, 2)
    }
    
    func test_removeAtInvalidIndex_returnsNil() {
        let linkedList = LinkedList<Int>()
        linkedList.append(1)
        
        var removed = linkedList.remove(at: 10)
        XCTAssertNil(removed)
        
        removed = linkedList.remove(at: -1)
        XCTAssertNil(removed)
        
        removed = linkedList.remove(at: 1)
        XCTAssertNil(removed)
        
    }
    
    func test_removeAt_twoElementList_removingFirst_updatesHeadAndTailCorrectly() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        linkedList.append(2)
        
        let removedElement = linkedList.remove(at: 0)
        
        XCTAssertEqual(removedElement, 1)
        XCTAssertEqual(linkedList.head?.value, 2)
        XCTAssertEqual(linkedList.tail?.value, 2)
        XCTAssertEqual(linkedList.count, 1)
    }
    
    // MARK: Insert at index tests
    
    func test_insertAtBeginning_insertsAtHead() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        
        linkedList.insert(at: 0, value: 0)
        
        XCTAssertEqual(linkedList.head?.value, 0)
        XCTAssertEqual(linkedList.tail?.value, 1)
        XCTAssertEqual(linkedList.count, 2)
    }
    
    func test_insertAtEnd_insertsAtTail() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        
        linkedList.insert(at: 1, value: 2)
        
        XCTAssertEqual(linkedList.head?.value, 1)
        XCTAssertEqual(linkedList.tail?.value, 2)
        XCTAssertEqual(linkedList.count, 2)
    }
    
    func test_insertAtMiddle_insertsCorrectly() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        linkedList.append(3)
        linkedList.append(4)
        
        linkedList.insert(at: 1, value: 2)
        
        for (element, val) in zip(linkedList, [1, 2, 3, 4]) {
            XCTAssertEqual(element, val)
        }
    }
    
    func test_insertAtOnEmptyList_insertsAtHead() {
        let linkedList = LinkedList<Int>()
        
        linkedList.insert(at: 0, value: 10)
        
        XCTAssertEqual(linkedList.head?.value, 10)
        XCTAssertEqual(linkedList.tail?.value, 10)
        XCTAssertEqual(linkedList.count, 1)
    }
    
    func test_insertAtInvalidIndex_doesNotInsert() {
        let linkedList = LinkedList<Int>()
        
        linkedList.append(1)
        
        linkedList.insert(at: -1, value: 0)
        XCTAssertEqual(linkedList.count, 1)
        
        linkedList.insert(at: 2, value: 2)
        XCTAssertEqual(linkedList.count, 1)
    }
    
}
