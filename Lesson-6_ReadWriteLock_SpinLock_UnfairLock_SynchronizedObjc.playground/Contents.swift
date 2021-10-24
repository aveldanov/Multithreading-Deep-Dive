

// LESSON 6 - ReadWriteLock, SpinLock, UnfairLock, Synchronized in Objc


/*
 more locks besides MUTEX
 
 ReadWriteLock - locks write/read or both. (not OBJ-C environment)
 */

import Foundation
import Darwin

class ReadWriteLock{
    
    private var lock = pthread_rwlock_t()
    private var attribute = pthread_rwlockattr_t()
    
    private var globalProperty: Int = 0
    
    
    init(){
        pthread_rwlock_init(&lock, &attribute)
    }
    
    
    public var workProperty: Int{
        // rebuiling GETTER and SETTER
        get{
            pthread_rwlock_rdlock(&lock)
            //actions...
            let temp = globalProperty
            pthread_rwlock_unlock(&lock)
            return temp //copy
        }
        
        set{
            pthread_rwlock_wrlock(&lock)
            //actions...
            globalProperty = newValue // newValue is Setter operator
            pthread_rwlock_unlock(&lock)
        }
    }
    
}


/*
 SpinLock - faster than mutex....deprecated!!!
 */

/*
class SpinLock{
    private var lock = OS_SPINLOCK_INIT
    
    func someMethod(){
        
        OSSpinLockLock(&lock)
        //Action...
        OSSpinLockUnlock(&lock)
    }
}
*/



/*
 UnfairLock replaced SpinLock starting iOS10.0
 no FOUNDATION
 */


class UnfairLock{
    private var lock = os_unfair_lock_s()
    
    var array = [Int]()
    
    func someMethod(){
        os_unfair_lock_lock(&lock)
        array.append(1)
        os_unfair_lock_unlock(&lock)
    }
}


/*
 SynchronizedObjC
 */

class SynchronizedObjC{
    private var lock = NSObject()
    
    var array = [Int]()

    func someMethod(){
        objc_sync_enter(lock)
        array.append(1)
        objc_sync_exit(lock)
    }
    
}
