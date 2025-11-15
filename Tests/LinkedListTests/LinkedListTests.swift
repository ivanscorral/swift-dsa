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
        
        XCTAssertNil(linkedList.head, "Newly initialized LinkedList should have nil head")
        XCTAssertNil(linkedList.tail, "Newly initialized LinkedList should have nil tail")
        XCTAssertEqual(linkedList.count, 0, "Newly initialized LinkedList should have count 0")
    }
    
    func test_listWithSingleElement_setsHeadAndTailToSameNode() {
        let linkedList = LinkedList<Int>()
        linkedList.append(5)
        
        XCTAssertEqual(linkedList.head?.value, 5, "Head value should be 5")
        XCTAssertEqual(linkedList.tail?.value, 5, "Tail value should be 5")
        XCTAssertEqual(linkedList.head, linkedList.tail, "Head and Tail should point to the same node")
    }
}
