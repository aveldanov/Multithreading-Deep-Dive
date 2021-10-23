import Foundation


//LESSON 5 - NSCondition,NSLocking, pthread_cond_t

/*
 
 We use condition to ensure that data writing is finished before it used
 
 */

//let condition = NSCondition()

/*
var isAvailable = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()


// C-level
class ConditionMutexPrinter: Thread{
    
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printerMethod()
    }
    
    private func printerMethod(){
        
        pthread_mutex_lock(&mutex)
        print("Printer Enter", isAvailable)
        while !isAvailable {
            pthread_cond_wait(&condition, &mutex)
        }
        isAvailable = false
        defer{
            pthread_mutex_unlock(&mutex)
        }
        print("Printer Exit")
    }
}


class ConditionMutexWriter: Thread{
    
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writerMethod()
    }
    
    private func writerMethod(){
        
        pthread_mutex_lock(&mutex)
        print("Writer Enter")

        isAvailable = true
        
        // Any actions
        
        pthread_cond_signal(&condition)
        
        defer{
            pthread_mutex_unlock(&mutex)
        }
        print("Writer Exit")
    }
}


let conditionMutexPrinter = ConditionMutexPrinter()
let conditionMutexWriter = ConditionMutexWriter()


conditionMutexPrinter.start()
conditionMutexWriter.start()

*/

// NS-condition


let condition = NSCondition()
var isAvailable = false

class WriterThread: Thread{
    
    override func main() {
        condition.lock()
        print("Writer Enter")
        isAvailable = true
        condition.signal()
        condition.unlock()
        print("Writer Exit")

    }
    
}

class PrinterThread: Thread{
    
    override func main() {
        condition.lock()
        print("Printer Enter")
        while !isAvailable{
            condition.wait()
        }
        
        isAvailable = false
        condition.unlock()
        print("Printer Exit")
    }
}


let writer = WriterThread()
let printer = PrinterThread()

printer.start()
writer.start()
