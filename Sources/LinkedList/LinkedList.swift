//
//  LinkedList.swift
//  swift-dsa
//
//  Created by Ivan Sanchez Corral on 15/11/25.
//

final public class LinkedList<Element> {
    public private(set) var head: Node<Element>?
    public private(set) var tail: Node<Element>?
    public private(set) var count: Int
    
    public init() {
        self.head = nil
        self.tail = nil
        self.count = 0
    }
    
    public func append(_ node: Node<Element>) {
        if count == 0 {
            head = node
            tail = head
        } else {
            tail?.next = node
            tail = node
        }
        
        count += 1
    }
    
    public func append(_ value: Element) {
        let newNode = Node(value)
        append(newNode)
    }
    
    public func prepend(_ value: Element) {
        let newNode = Node(value)
        
        newNode.next = head
        head = newNode
        
        if count == 0 {
            tail = head
        }
        
        count += 1
    }
    
    public func element(at index: Int) -> Element? {
       _node(at: index)?.value
    }
}

private extension LinkedList {
    func _node(at index: Int) -> Node<Element>? {
        guard index >= 0 && index < count else { return nil }
        
        if index == 0 { return head }
        if index == count - 1 { return tail }
        
        var current = head
        for _ in 0..<index { current = current?.next }
        
        return current
    }
}

extension LinkedList: Sequence {
    public func makeIterator() -> AnyIterator<Element> {
        var current = head
        return AnyIterator {
            defer { current = current?.next }
            return current?.value
        }
    }
}
