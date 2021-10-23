import Darwin
import UIKit


// LESSON 2 - Quality Of Service (QoS)

// C-level
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


// Same threads in Objective-C level

let nsThread = Thread{
    
    print("test2")
    // print qos of the current class
    print(qos_class_self())
}

nsThread.qualityOfService = .userInteractive
nsThread.start()

print(qos_class_main())



/*
 
 QoS Types:
 
 - userInteractive:
 Used for animations, or updating UI.

 - userInitiated:
 Used for tasks like loading data from API, preventing the user from making interactions.

 - utility:
 Used for tasks that do not need to be tracked by the user.

 - background:
 Used for tasks like saving data in the local database or any maintenance code which is not on high priority.
 */
