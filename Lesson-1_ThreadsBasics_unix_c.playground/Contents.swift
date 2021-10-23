/*
 1. Thread
 2. Operation
 3. GCD
 */

import Darwin
import UIKit


//LESSON 1

// Unix - POSIX
// All in C

 
 // & -> address in C.

var thread = pthread_t(bitPattern: 0) // created a thread
var attribute = pthread_attr_t() // create attribute
pthread_attr_init(&attribute) // &- from C-language
pthread_create(&thread, &attribute, { pointer in
    print("test1")
    return nil
}, nil)


// Thread

var nsthread = Thread {
    print("test2")
}

 
nsthread.start()



