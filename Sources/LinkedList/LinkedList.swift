//
//  LinkedList.swift
//  swift-dsa
//
//  Created by Ivan Sanchez Corral on 15/11/25.
//

public class LinkedList<Element: Equatable> {
    public private(set) var head: Node<Element>?
    public private(set) var tail: Node<Element>?
    public private(set) var count: Int
    
    init() {
        self.head = nil
        self.tail = nil
        self.count = 0
    }
    
    func append(_ value: Element) {
        let newNode = Node(value)
        if count == 0 {
            head = newNode
            tail = head
        } else {
            tail?.next = newNode
            tail = newNode
        }
        
        count += 1
    }
    
    func prepend(_ value: Element) {
        let newNode = Node(value)
        
        newNode.next = head
        head = newNode
        
        if count == 0 {
            tail = head
        }
        
        count += 1
    }
    
    func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        
        return _node(at: index)?.value
    }
    
    func array() -> [Element] {
        var result = [Element]()
        for i in 0..<count {
            result.append(_node(at: i)!.value)
        }
        
        return result
    }
    
    func _node(at index: Int) -> Node<Element>? {
        guard index >= 0 && index < count else { return nil }
        
        var current = head
        for _ in 0..<index { current = current?.next }
        
        return current
    }
}

public class Node<Element: Equatable> {
    public var value: Element
    public var next: Node?
    
    init(_ value: Element) {
        self.value = value
        self.next = nil
    }
}

extension Node: Equatable {
    public static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
        rhs === lhs
    }
}
