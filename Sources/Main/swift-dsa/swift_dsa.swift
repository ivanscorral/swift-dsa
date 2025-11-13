// The Swift Programming Language
// https://docs.swift.org/swift-book
import Arrays

@main
struct swift_dsa {
    
    static func main() {
        testDynamicArray()
    }
    
    static func testDynamicArray() {
        let dynamicIntArray = DynamicArray<Int>()
        
        for i in 0..<20 {
            dynamicIntArray.append(i)
        }
        
        for i in 0..<dynamicIntArray.count {
            if let value = dynamicIntArray.get(at: i) {
                print("Value at index \(i): \(value)")
            }
        }
        
    }
}

