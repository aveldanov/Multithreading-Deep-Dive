/*
 1. Thread
 2. Operation
 3. GCD
 */

import Darwin
import UIKit

/*
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

*/



// LESSON 2 - Quality Of Service (QoS)

var pthread = pthread_t(bitPattern: 0)
var attribute = pthread_attr_t()

pthread_attr_init(&attribute)

// configure attribute
// attribute // QOS-thread(main, etc) // Priority - the higher number the higher priority
pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_USER_INITIATED, 0)
pthread_create(&pthread, &attribute, { pointer in
    print("test")
    pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)
    return nil
}, nil)
