//
//  DynamicArray.swift
//  swift-dsa
//
//  Created by Ivan Sanchez Corral on 13/11/25.
//

import Foundation

public final class DynamicArray<Element> {
    public private(set) var count: Int
    private var storage: UnsafeMutablePointer<Element>
    private var capacity: Int
    
    public convenience init() {
        self.init(capacity: 8)
    }
    
    public init(capacity: Int) {
        self.storage = .allocate(capacity: capacity)
        self.count = 0
        self.capacity = capacity
    }
    
    deinit {
        storage.deallocate()
    }
    
    /// Appends a new element to the end of the dynamic array.
    /// - Parameter value: The element to append.
    public func append(_ value: Element) {
        if count == capacity {
            resize()
        }
        
        (storage + count).initialize(to: value)
        count += 1
    }
    
    private func resize(to newCapacity: Int? = nil) {
        let newCap = newCapacity ?? capacity * 2
        
        let newStorage = UnsafeMutablePointer<Element>.allocate(capacity: newCap)
       
        newStorage.moveInitialize(from: storage, count: count)
        
        storage.deallocate()
        storage = newStorage
        capacity = newCap
    }
    /// Retrieves the element at the specified index.
    /// - Parameter index: The index of the element to retrieve.
    /// - Returns: The element at the specified index, or `nil` if the index is out of bounds.
    public func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }
        
        return storage[index]
    }
    
    /// Sets the element at the specified index to a new value.
    /// - Parameters: index: The index of the element to set. value: The new value to set
    public func set(at index: Int, value: Element) {
        guard index >= 0 && index < count else { return }
        
        storage[index] = value
    }
}

