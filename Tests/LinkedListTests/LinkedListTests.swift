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
    
}
