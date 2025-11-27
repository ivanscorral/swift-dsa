//
//  Node.swift
//  swift-dsa
//
//  Created by Ivan Sanchez Corral on 15/11/25.
//

final public class Node<Element> {
    public var value: Element
    public var next: Node<Element>?
    
    public init(_ value: Element) {
        self.value = value
        self.next = nil
    }
}

extension Node: Equatable {
    public static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
        rhs === lhs
    }
}
