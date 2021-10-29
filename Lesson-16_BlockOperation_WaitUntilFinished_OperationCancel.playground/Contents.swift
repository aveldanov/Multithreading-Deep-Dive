
//LESSON 16 - BlockOperation & WaitUntilFinished & OperationCancel
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


let operationQueue = OperationQueue()

class OperationCancelTest: Operation{
    
    override func main() {
//        sleep(1)
        if isCancelled{
            print("isCancelled",isCancelled)
            return
        }
        
        print(Thread.current)
        print("Test 1")
        sleep(1)
        
        if isCancelled{
            print("isCancelled2",isCancelled)
            return
        }
        print(Thread.current)
        print("Test 2")
        
        
        
        if isCancelled{
            print("isCancelled3",isCancelled)
            return
        }
        
        print(Thread.current)
        print("Test 3")
        sleep(1)
        
        if isCancelled{
            print("isCancelled4",isCancelled)
            return
        }
        print(Thread.current)
        print("Test 4")
    }
    
    
}


func cancelOperationMethod(){
    let cancelOperation = OperationCancelTest()
    operationQueue.addOperation(cancelOperation)
    sleep(2)
    cancelOperation.cancel()
}

//cancelOperationMethod()



class WaitOperationTest{
    
    private let operationQueue = OperationQueue()
    
    func check(){
        operationQueue.addOperation {
            sleep(1)
            print("Test 1")
        }
        
        operationQueue.addOperation {
            sleep(2)
            print("Test 2")
        }
        
        // Barrier that blocks below until above is finisged
        operationQueue.waitUntilAllOperationsAreFinished()
        operationQueue.addOperation {
            print("Test 3")
        }
        
        operationQueue.addOperation {
            print("Test 4")
        }
    }
}

let waitOperationTest = WaitOperationTest()
waitOperationTest.check()
