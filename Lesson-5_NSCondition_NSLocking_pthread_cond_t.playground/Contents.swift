import Foundation


//LESSON 5 - NSCondition,NSLocking, pthread_cond_t

/*
 
 We use condition to ensure that data writing is finished before it used
 
 */

//let condition = NSCondition()


var isAvailable = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()



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
        print("Printer Enter")
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
        
        pthread_cond_signal(&condition)
        
        defer{
            pthread_mutex_unlock(&mutex)
        }
        print("Writer Exit")
    }
}
