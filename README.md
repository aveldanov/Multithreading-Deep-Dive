# Multithreading-Deep-Dive
[IN-PROGRESS]


Deep Dive(C-level) Multithreading Practice
- Threads
- Operations
- Grand Central Dispatch (GCD)
- - -

 ## Concurrency Problems:
 
  **Race Conditions** – Occurs when processes that must occur in a particular order occur out of order due to multiple threading.
 
  **Deadlock** – Occurs when two competing processes are waiting for each other to finish, allowing neither to finish.

  **Starvation** – Occurs when a process never gains accesses to resources, never allowing the program to finish.

  **Livelock** – Occurs when two threads are dependent on each other signals and are both threads respond to each others signals. If this is the case, the threads can cause a loop similar to something between a deadlock and starvation.
 
  **Priority inversion** - Technically speaking, priority inversion occurs when a queue with a lower quality of service is given higher system priority than a queue with a higher quality of service, or QoS.
 

</br>



## Steps to Queue Management:
### 1) Global vs Main(serial queue)
### 2) Set priority for Global

The QoS classes are:

**User-interactive:** This represents tasks that must complete immediately in order to provide a nice user experience. Use it for UI updates, event handling and small workloads that require low latency. The total amount of work done in this class during the execution of your app should be small. This should run on the main thread.

**User-initiated:** The user initiates these asynchronous tasks from the UI. Use them when the user is waiting for immediate results and for tasks required to continue user interaction. They execute in the high priority global queue.

**Utility:** This represents long-running tasks, typically with a user-visible progress indicator. Use it for computations, I/O, networking, continuous data feeds and similar tasks. This class is designed to be energy efficient. This will get mapped into the low priority global queue.

**Background:** This represents tasks that the user is not directly aware of. Use it for prefetching, maintenance, and other tasks that don’t require user interaction and aren’t time-sensitive. This will get mapped into the background priority global queue.


### 3) Sync vs Async

<br>
<br>


----


## Mutex
 Mutex — ensures that only one thread is active in a given region of code at a time. You can think of it as a semaphore with a maximum count of 1.
 
 Mutex is blocking and releasing objects

 when the object is Mutex protected - the thread pinging it is in WAIT mode until Mutex is released
 
 SWIFT can't do anything about threads. It uses either Libraries(GCD) or Objective-C(nsThread)
 C-level functions work 15-20 faster than GCD or NSLock!!!


<details>
  <summary markdown="span">Mutex Code Example</summary>

```
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




```
</details>



----


## WorkItem

 DispatchWorkItem - abstraction level to wrap your task so you can start/cancel/notify/etc your task. <p>
 
 **NOTE!**  GCD cannot cancel workItem if already started. YET Operations can, so many switch to operations


----

## Semaphore

A semaphore consists of a threads queue and a counter value (type Int). The threads queue is used by the semaphore to keep track of waiting threads in FIFO order (The first thread entered into the queue will be the first to get access to the shared resource once it is available).

Semaphore with `value == 1` (number of active threads), is MUTEX. So just one thread allowed.

<details>
  <summary markdown="span">Semaphore Code Example</summary>

```
let semaphore = DispatchSemaphore(value: 0)

queue.async {
    semaphore.wait() // value-=1 , leaving one thread available
    sleep(3)
    print(Thread.current)
    print("Method 1")
    semaphore.signal() // value+=1, adding one more thread
}

```
</details>

----

## DispatchGroup

Groups allow you to aggregate a set of tasks and synchronize behaviors on the group. You attach multiple work items to a group and schedule them for asynchronous execution on the same queue or different queues. When all work items finish executing, the group executes its completion handler. You can also wait synchronously for all tasks in the group to finish executing.

<details>
  <summary markdown="span">DispatchGroup Code Example (Serial Queue)</summary>

```
class DispatchGroupTest1{
    
    private let queueSerial = DispatchQueue(label: "DispatchGroupQueue1")
    private let groupRed = DispatchGroup()
    
    func loadInfo(){
        queueSerial.async(group: groupRed){
            sleep(1)
            print("1")
        }
        
        queueSerial.async(group: groupRed){
            sleep(1)
            print("2")
        }
        // Similar to WorkItem
        groupRed.notify(queue: .main) {
            print("Finished All")
        }
    }
}

```
</details>


----

## DispatchBarrier

The `.barrier` flag means that it will wait until every currently running block in the queue is finished executing before it executes. Other blocks will queue up behind it and be executed when the barrier dispatch is done.

When the barrier is executing, it essentially acts as a serial queue. That is, the barrier is the only thing executing. After the barrier finishes, the queue goes back to being a normal concurrent queue. 

<details>
  <summary markdown="span">DispatchBarrier Code Example</summary>

```
private let concurrentQueue = DispatchQueue(label: "com.gcd.dispatchBarrier", attributes: .concurrent)
for value in 1...5 {
    concurrentQueue.async() {
        print("async \(value)")
    }
}
for value in 6...10 {
    concurrentQueue.async(flags: .barrier) {
        print("barrier \(value)")
    }
}
for value in 11...15 {
    concurrentQueue.async() {
        print("sync \(value)")
    }
}


PRINTOUT:
// NOTE: The race condition for the first 5 items:
async 1
async 5
async 2
async 3
async 4
barrier 6
barrier 7
barrier 8
barrier 9
barrier 10
sync 11
sync 12
sync 13
sync 14
sync 15


```
</details>



----

## DispatchSource

An object that coordinates the processing of specific low-level system events, such as file-system events, timers, and UNIX signals. Like timers, observe changes in a file on the file system, socket management etc



----

## Operation & OperationQueue & OperationBlock
One of key difference GCD and Operation, that in Operation the task can be canceled even when it is started execution. In GCD once queue started - no way to cancel a task.


<details>
  <summary markdown="span">Operations Code Example</summary>

```
print(Thread.current) //main

class OperationA: Operation{
    
    override func main() {
        print("inside",Thread.current)
        print("Test Operation") // global when with Operation
    }
}

let operationA = OperationA()
//operationA.start()

let queue1 = OperationQueue()
queue1.addOperation(operationA)
```
</details>



----

## BlockOperation & WaitUntilFinished & OperationCancel



<details>
  <summary markdown="span">WaitUntil Code Example</summary>

```
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

PRINT OUT:
Test 1
Test 2
Test 3
Test 4

```
</details>



<details>
  <summary markdown="span">CompletionBlock Code Example</summary>

```
class CompletionBlockTest{
    private let operationQueue = OperationQueue()

    
    func check3(){
        let operation1 = BlockOperation{
            sleep(1)
            print("Test 1 ")
        }
        // Completion Block
        operation1.completionBlock = {
            print("Completion Block Finished")
        }
        operationQueue.addOperation(operation1)
    }
}

let completionBlockTest = CompletionBlockTest()
completionBlockTest.check3()

```
</details>
