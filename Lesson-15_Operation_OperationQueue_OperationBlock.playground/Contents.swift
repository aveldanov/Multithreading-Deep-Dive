// LESSON 15 - Operation & OperationQueue & OperationBlock

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// OPTION 1

//print(Thread.current)

//Closure...Not Operation!
//let operation1 = {
//    print("Start")
//    print(Thread.current)
//    print("Finish")
//}
//
//let queue = OperationQueue()
//queue.addOperation(operation1)


// OPTION 2
//
//print(Thread.current)
//
//var result: String?
//let concatOperation = BlockOperation{
//    result = "Operation Result"+"!"
//    print(Thread.current)
//}
//
////concatOperation.start()
////print(result)
//
//
//let queue = OperationQueue()
//queue.addOperation(concatOperation)
//sleep(2)
//print("Result",result)

// OPTION 3

//let queue1 = OperationQueue()
//print(Thread.current)
//
//queue1.addOperation {
//    print("test1")
//    print(Thread.current)
//}



// OPTION 4

//print(Thread.current)
//class MyThread: Thread{
//
//    override func main() {
//        print("Test Main Thread")
//    }
//}
//
//let myThread = MyThread()
//myThread.start()



print(Thread.current) //main

class OperationA: Operation{
    
    override func main() {
        print("inside",Thread.current)
        print("Test Operation") // global when with Operation
    }
}

let operationA = OperationA()
//operationA.start()

let queue1 = OperationQueue()
queue1.addOperation(operationA)
