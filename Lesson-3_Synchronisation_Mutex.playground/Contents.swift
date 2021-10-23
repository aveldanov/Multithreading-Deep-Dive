
// LESSON 3 - Synchronisation & Mutex

// When READ and WRITE happening at the same time
// If not syncrinized - broken data


/*
 
 Mutex — ensures that only one thread is active in a given region of code at a time. You can think of it as a semaphore with a maximum count of 1.
 
 Mutex is blocking and releasing objects
 
 when the object is Mutex protected - the thread pinging it is in WAIT mode until Mutex is released
 */

import UIKit


class SaveThread{
    private var mutex = pthread_mutex_t()
    
    init(){
        pthread_mutex_init(&mutex, nil)
    }
    
    func someMethod(completion: ()->Void){
        
        //locking our object
        pthread_mutex_lock(&mutex)
        
        // some data blah-blah
        
        //unlocking object
        pthread_mutex_unlock(&mutex)
    }
}



