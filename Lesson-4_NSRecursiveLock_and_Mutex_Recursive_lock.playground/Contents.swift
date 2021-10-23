

// LESSON 4 - NSRecursiveLock & Mutex Recursive lock


/*
 
 Concurrency Problems:
 
 Race Conditions – Occurs when processes that must occur in a particular order occur out of order due to multiple threading.
 
 Deadlock – Occurs when two competing processes are waiting for each other to finish, allowing neither to finish.

 Starvation – Occurs when a process never gains accesses to resources, never allowing the program to finish.

 Livelock – Occurs when two threads are dependent on each other signals and are both threads respond to each others signals. If this is the case, the threads can cause a loop similar to something between a deadlock and starvation.
 
 Priority inversion - Technically speaking, priority inversion occurs when a queue with a lower quality of service is given higher system priority than a queue with a higher quality of service, or QoS.
 
 
 */

/*
 Do not use NSLock for recursive calls. If you use it twice(because of recursion) it will lock your method forever. Use NSRecursiveLock instead!!!
 
 
 */


import UIKit



class RecursiveMutexTest{
    private var mutex = pthread_mutex_t()
    private var attribute = pthread_mutexattr_t()
    
    init(){
        pthread_mutexattr_init(&attribute)
//        pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attribute)
    }
    
    func firstTask(){
        pthread_mutex_lock(&mutex)
        secondTask()
        defer{
            pthread_mutex_unlock(&mutex)
        }
    }
    
    private func secondTask(){
        pthread_mutex_lock(&mutex)
        print("FINISH")
        // to unlock even if the method flow is broken
        defer{
            pthread_mutex_unlock(&mutex)
        }
    }
}



let recursive = RecursiveMutexTest()
recursive.firstTask()




let recursiveLock = NSRecursiveLock()


class RecursiveThread: Thread{
    
    // let's use main function
    override func main() {
        recursiveLock.lock()
        print("Thread acquired lock")
        taskTwo()
        defer{
            recursiveLock.unlock()
        }
        
        print("exit main() ")

    }
    
    
    func taskTwo(){
        recursiveLock.lock()
        print("Thread acquired lock")
        
        defer{
            recursiveLock.unlock()
        }
        
        print("exit taskTwo ")
    }
}


let thread = RecursiveThread()
thread.start()
