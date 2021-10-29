
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


class SafeArray(){
    
    
}
