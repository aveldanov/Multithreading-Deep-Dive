//
//  SecondViewController.swift
//  Lesson-9_GCD_AsyncAfter_ConcurrentPerform_InitiallyInactive
//
//  Created by Anton Veldanov on 10/24/21.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//
//        for i in 0...200000{
//            print(i)
//        }
        
//------       //Concurrent Interations in multiple Threads, similar to FOR
//        DispatchQueue.concurrentPerform(iterations: 200000) {
//            print("\($0) times")
//            print(Thread.current)
//        }
        
        
// ------ Same thing, but excluding MAIN. Not blockng UI!
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            DispatchQueue.concurrentPerform(iterations: 200000) {
//                print("\($0) times")
//                print(Thread.current)
//            }
//        }
        
        myInactiveQueue()

        
    }
    
    
    func myInactiveQueue(){
        let inactiveQueue = DispatchQueue(label: "SwiftDevQueue",  attributes: [.concurrent, .initiallyInactive])
        inactiveQueue.async {
            print("Done")
        }
        
        print("Not yet started....")
        inactiveQueue.activate()
        print("Queue is Active now! ")
        inactiveQueue.suspend()
        print("Pause")
        inactiveQueue.resume()
        print("Resumed!")
    }
}
