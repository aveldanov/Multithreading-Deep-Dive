
// LESSON 11 - GCD Semaphore

import UIKit
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true


let queue = DispatchQueue(label: "Lesson11 Queue", attributes: .concurrent)


// Create semaphore. Value 2 - number of threads can be passed.
let semaphore = DispatchSemaphore(value: 2)


queue.async {
    semaphore.wait() // value-=1 , leaving one thread available
    sleep(5)
    print("Method 1")
    semaphore.signal() // value+=1, adding one more thread
}

queue.async {
    semaphore.wait()
    sleep(5)
    print("Method 2")
    semaphore.signal()
}

queue.async {
    semaphore.wait()
    sleep(5)
    print("Method 3")
    semaphore.signal()
}
