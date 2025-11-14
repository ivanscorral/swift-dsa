// The Swift Programming Language
// https://docs.swift.org/swift-book
import Arrays

@main
struct swift_dsa {
    
    static func main() {
        testDynamicArray()
    }
    
    static func testDynamicArray() {
        var dynamicIntArray: DynamicArray<Int> = DynamicArray<Int>()
        
        for i in 0..<20 {
            dynamicIntArray.append(i)
        }
        
        for i in 0..<dynamicIntArray.count {
            print("Value at index \(i): \(dynamicIntArray[i])")
        }
        
        // Test out of bounds access
        
        dynamicIntArray[20] = 0
        
    }
}

