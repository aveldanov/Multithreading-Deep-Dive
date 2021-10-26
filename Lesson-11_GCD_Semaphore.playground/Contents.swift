
// LESSON 11 - GCD Semaphore


/*
 
 A semaphore consists of a threads queue and a counter value (type Int). The threads queue is used by the semaphore to keep track of waiting threads in FIFO order (The first thread entered into the queue will be the first to get access to the shared resource once it is available).
 
Semaphore with value == 1, called MUTEX
 
 if value == 2, then 2 threads will start and then freed up another one will be added
 */

import UIKit
import PlaygroundSupport
import Darwin




PlaygroundPage.current.needsIndefiniteExecution = true


let queue = DispatchQueue(label: "Lesson11 Queue", attributes: .concurrent)


// Create semaphore. Value = 2 - number of threads can be passed.
let semaphore = DispatchSemaphore(value: 0)


queue.async {
    semaphore.wait() // value-=1 , leaving one thread available
    sleep(3)
    print(Thread.current)
    print("Method 1")
    semaphore.signal() // value+=1, adding one more thread
}

queue.async {
    semaphore.wait()
    sleep(3)
    print(Thread.current)
    print("Method 2")
    semaphore.signal()
}

queue.async {
    semaphore.wait()
    sleep(3)
    print(Thread.current)
    print("Method 3")
    semaphore.signal()
}








let semaphore2 = DispatchSemaphore(value: 2)

DispatchQueue.concurrentPerform(iterations: 10) { (id:Int) in
    
    print(Thread.current)
    semaphore2.wait(timeout: DispatchTime.distantFuture)
    print("Block print", id)
    
    semaphore2.signal()
}


