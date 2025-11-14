// The Swift Programming Language
// https://docs.swift.org/swift-book
import Arrays

@main
struct swift_dsa {
    
    static func main() {
        testDynamicArray()
    }
    
    static func testDynamicArray() {
        var dynamicIntArray: DynamicArray<Int> = []
        
        dynamicIntArray.insert(10, at: 0)
        dynamicIntArray.insert(100, at: dynamicIntArray.count)
        dynamicIntArray.printElements()
        dynamicIntArray.append(50)
        dynamicIntArray.printElements()
        let firstIndex100 = dynamicIntArray.firstIndex(of: 100)
        print("Index of 100: \(String(describing: firstIndex100))")
        print("Contains 50: \(dynamicIntArray.contains(50))")

    }
}


