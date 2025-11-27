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
    
    @discardableResult
    public func removeFirst() -> Element? {
        guard count > 0, let first = head else { return nil }
        
        head = head?.next
        count -= 1
        
        if count == 0 {
            tail = nil
        }
        
        return first.value
    }
    
    @discardableResult
    public func removeLast() -> Element? {
        guard count > 0, let last = tail else { return nil }
        
        if count == 1 {
            head = nil
            tail = nil
        } else {
            var current = head
            while current?.next !== tail {
                current = current?.next
            }
            tail = current
        }
        
        count -= 1
        return last.value
    }
    
    @discardableResult
    public func remove(at index: Int) -> Element? {
        guard index >= 0, index < count, count > 0 else { return nil }
                
        if index == 0 {
            return removeFirst()
        } else if index == count - 1 {
            return removeLast()
        } else {
            let previous = _node(at: index - 1)
            let removedNode = previous?.next
            previous?.next = removedNode?.next
            count -= 1
            return removedNode?.value
        }
    }
    
    public func insert(at index: Int, value: Element) {
        guard index >= 0, index <= count else { return } 
        
        if index == 0 {
            prepend(value)
        } else if index == count {
            append(value)
        } else {
            let newNode = Node(value)
            let previous = _node(at: index - 1)
            newNode.next = previous?.next
            previous?.next = newNode
            count += 1
        }
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
