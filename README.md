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
