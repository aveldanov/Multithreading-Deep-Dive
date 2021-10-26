
//LESSON 10 - GCD DispatchWorkItem, notify


import UIKit
import PlaygroundSupport

//to execute long actions
PlaygroundPage.current.needsIndefiniteExecution = true

let urlString = "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"



class DispatchWorkItem1{
    
    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
    
    func create(){
        // workItem - working abstraction
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start Task")
        }
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("Task finished")
        }
        
        queue.async(execute: workItem)
    }
}


let dispatchWorkItem1 = DispatchWorkItem1()

dispatchWorkItem1.create()
