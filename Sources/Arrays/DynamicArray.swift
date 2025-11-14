//
//  DynamicArray.swift
//  swift-dsa
//
//  Created by Ivan Sanchez Corral on 13/11/25.
//

import Foundation

public struct DynamicArray<Element> {
    private var internalArray: InternalDynamicArray<Element>
    
    public var count: Int { internalArray.count }
    public var isEmpty: Bool { internalArray.count == 0 }
    
    public init() {
        self.internalArray = InternalDynamicArray<Element>()
    }
    
    public mutating func append(_ value: Element) {
        internalArray.append(value)
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
    
    // TODO: Implement Copy-on-Write semantics
}

private final class InternalDynamicArray<Element> {
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
    
    func append(_ value: Element) {
        if count == capacity {
            resize()
        }
        
        (storage + count).initialize(to: value)
        count += 1
    }
    
    func resize(to newCapacity: Int? = nil) {
        let newCap = newCapacity ?? capacity * 2
        
        let newStorage = UnsafeMutablePointer<Element>.allocate(capacity: newCap)
       
        newStorage.moveInitialize(from: storage, count: count)
        
        freeRawStorage()
        
        storage = newStorage
        capacity = newCap
    }
    
    func get(at index: Int) -> Element {
        guard index >= 0 && index < count else { fatalError("Index out of bounds") }
        
        return storage[index]
    }
    
    func set(at index: Int, value: Element) {
        guard index >= 0 && index < count else { return }
        
        storage[index] = value
    }
}

private extension InternalDynamicArray {
    func deallocate() {
        storage.deinitialize(count: count)
        storage.deallocate()
    }
    
    func freeRawStorage() {
        storage.deallocate()
    }
}

