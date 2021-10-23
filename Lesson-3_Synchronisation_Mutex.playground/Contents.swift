
// LESSON 3 - Synchronisation & Mutex

// When READ and WRITE happening at the same time
// If not syncrinized - broken data


/*
 
 Mutex — ensures that only one thread is active in a given region of code at a time. You can think of it as a semaphore with a maximum count of 1.
 
 Mutex is blocking and releasing objects
 
 when the object is Mutex protected - the thread pinging it is in WAIT mode until Mutex is released
 
 
 SWIFT can't do anything about threads. It uses either Libraries(GCD) or Objective-C(nsThread)
 
 
 
 
 C-level functions work 15-20 faster than GCD or NSLock!!!
 */
import UIKit



/*
// C-level
 
class SaveThread{
    private var mutex = pthread_mutex_t()
    
    init(){
        pthread_mutex_init(&mutex, nil)
    }
    
    func someMethod(completion: ()->Void){
        //locking our object
        pthread_mutex_lock(&mutex)
        
        // some data blah-blah
        // call completion to pass the completion parameter
        completion()
        
        
        // in case there is a crash, our thread won't be unlocked. That is why we need to use DEFER. It will guaranteed to unlock thread
        
        defer{
            //unlocking object
            pthread_mutex_unlock(&mutex)
        }
    }
}


*/



// Objective-C level

class SaveThread{
    private let lockMutex = NSLock()
    
    func someMethod(completion: ()->Void){
        
        lockMutex.lock()
        completion()
        
        
        defer{
            lockMutex.unlock()
        }
    }
}


var arr = [String]()
let saveThread = SaveThread()

saveThread.someMethod {
    print("test")
    arr.append("1 thread")
}

arr.append("2 thread")
