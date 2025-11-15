//
//  DynamicArray.swift
//  swift-dsa
//
//  Created by Ivan Sanchez Corral on 13/11/25.
//

import Foundation

public struct DynamicArray<Element> where Element: Equatable {
    private let internalArray: InternalDynamicArray<Element>
    
    public var count: Int { internalArray.count }
    public var isEmpty: Bool { internalArray.count == 0 }
    
    public init() {
        self.internalArray = InternalDynamicArray<Element>()
    }
    
    public init(arrayLiteral elements: Element...) {
        self.internalArray = InternalDynamicArray<Element>()
        for element in elements {
            internalArray.append(element)
        }
    }
    
    public mutating func append(_ value: Element) {
        internalArray.append(value)
    }
    
    public mutating func insert(_ value: Element, at index: Int) {
        internalArray.insert(value, at: index)
    }
    
    public func contains(_ element: Element) -> Bool {
        return internalArray.firstIndex(of: element) != nil
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> Element {
        return internalArray.remove(at: index)
    }
    
    public func firstIndex(of element: Element) -> Int? {
        return internalArray.firstIndex(of: element)
    }
    
    public func clear() {
        internalArray.clear()
    }
    
    public subscript(index: Int) -> Element {
        get {
            precondition(index >= 0 && index < internalArray.count, "Index out of bounds")
            return internalArray.get(at: index)
        }
        set {
            precondition(index >= 0 && index < internalArray.count, "Index out of bounds")
            internalArray.set(at: index, value: newValue)
        }
    }
    
    public func printElements() {
        for i in 0..<internalArray.count {
            print(internalArray.get(at: i))
        }
    }
    
    
    
    // TODO: Implement Copy-on-Write semantics
}

extension DynamicArray: ExpressibleByArrayLiteral {}

private final class InternalDynamicArray<Element> where Element: Equatable {
    public private(set) var count: Int
    private var storage: UnsafeMutablePointer<Element>
    private var capacity: Int
    
    convenience init() {
        self.init(capacity: 8)
    }
    
    init(capacity: Int) {
        self.storage = .allocate(capacity: capacity)
        self.count = 0
        self.capacity = capacity
    }
    
    deinit {
        deallocate()
    }
    
    func insert(_ value: Element, at index: Int) {
        precondition(index >= 0 && index <= count, "Index out of bounds")
        if count == capacity { resize() }
        
        for i in (stride(from: count - 1, through: index, by: -1)) {
            storage[i + 1] = storage[i]
        }
        
        storage[index] = value
        count += 1
    }
    
    func remove(at index: Int) -> Element {
        guard index >= 0 && index < count else { fatalError("Index out of bounds") }
        
        let removedElement = storage[index]
        
        for i in index..<(count - 1) {
            storage[i] = storage[i + 1]
        }
        
        count -= 1
        
        (storage + count).deinitialize(count: 1)
        
        return removedElement
    }
    
    func firstIndex(of element: Element) -> Int? {
        for i in 0..<count {
            if storage[i] == element {
                return i
            }
        }
        return nil
    }
    
    func append(_ value: Element) {
        if count == capacity { resize() }
        
        (storage + count).initialize(to: value)
        count += 1
    }
    
    func get(at index: Int) -> Element {
        guard index >= 0 && index < count else { fatalError("Index out of bounds") }
        
        return storage[index]
    }
    
    func set(at index: Int, value: Element) {
        guard index >= 0 && index < count else { fatalError("Index out of bounds") }
        
        storage[index] = value
    }
    
    func clear() {
        storage.deinitialize(count: count)
        count = 0
    }
}

private extension InternalDynamicArray {
    func deallocate() {
        storage.deinitialize(count: count)
        storage.deallocate()
    }
    
    func resize(to newCapacity: Int? = nil) {
        let newCap = newCapacity ?? capacity * 2
        
        precondition(newCap > capacity, "New capacity must be greater than current capacity")
        
        let newStorage = UnsafeMutablePointer<Element>.allocate(capacity: newCap)
        newStorage.moveInitialize(from: storage, count: count)
        
        storage.deallocate()
        
        storage = newStorage
        capacity = newCap
    }
}

