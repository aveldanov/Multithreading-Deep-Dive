
// LESSON 13 - GCD Dispatch Barrier

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var array = [Int]()

// Serial queue
//for i in 0...9{
//    array.append(i)
//}
//print(array, array.count)


// Same thing but in concurrent

//DispatchQueue.concurrentPerform(iterations: 10) { index in
//    array.append(index)
//}
//// Shows race condition - array is messy and not full: [3, 5, 6, 7, 8, 9] 6

//print(array, array.count)


class SafeArray<T>{
    private var array = [T]()
    private let queue = DispatchQueue(label: "Safe Array Queue", attributes: .concurrent)
    
    // lock write
    public func appendItem(_ value: T){
        queue.async( flags: .barrier) {
            self.array.append(value)
        }
    }
    
    // lock read
    public var valueArray:[T]{
        var result = [T]()
        // wait until async is done and only after that sync adding:
        queue.sync {
            result = self.array
        }
        return result
    }
}

var arraySafe = SafeArray<Int>()

DispatchQueue.concurrentPerform(iterations: 10) { index in
    arraySafe.appendItem(index)
}

//print(arraySafe.valueArray)



private let concurrentQueue = DispatchQueue(label: "com.gcd.dispatchBarrier", attributes: .concurrent)
for value in 1...5 {
    concurrentQueue.async() {
        print("async \(value)")
    }
}
for value in 6...10 {
    concurrentQueue.async(flags: .barrier) {
        print("barrier \(value)")
    }
}
for value in 11...15 {
    concurrentQueue.async() {
        print("sync \(value)")
    }
}
