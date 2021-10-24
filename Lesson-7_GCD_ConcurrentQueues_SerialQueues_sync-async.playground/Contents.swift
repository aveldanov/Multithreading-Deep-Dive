
// LESSON 7 - GCD,Concurrent queues, Serial queues,sync-async

import UIKit


class QueueTest1{
    
    // you can creat own queues on top of Apple created (global, main, etc)
    private let serialQueue = DispatchQueue(label: "serialTest")
    private let concurrentQueue = DispatchQueue(label: "concurrentTest", attributes: .concurrent)
    
}


class QueueTest2{
    // access apple queues:
    private let globalQueue = DispatchQueue.global()
    private let mainQueue = DispatchQueue.main
    
}
