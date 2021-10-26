
//LESSON 10 - GCD DispatchWorkItem, notify

/*
 
 DispatchWorkItem - abstraction level to wrap your task so you can start/cancel/ntoify/etc your task
 
 NOTE!  GCD cannot cancel workItem if already started. YET Operations can, so many switch to operations
 
 */


import UIKit
import PlaygroundSupport

//to execute long actions
PlaygroundPage.current.needsIndefiniteExecution = true


// Concurrent

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
//dispatchWorkItem1.create()


//Serial
class DispatchWorkItem2{
    //Serial queue
    private let queue = DispatchQueue(label: "DispatchWorkItem2")
    
    func create(){
        queue.async {
            sleep(2)
            print(Thread.current)
            print("Task1")
        }
        
        queue.async {
            sleep(2)
            print(Thread.current)
            print("Task2")
        }
        
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start work item task 3")
        }
        
        workItem.cancel()
        queue.async(execute: workItem)
    }
}


let dispatchWorkItem2 = DispatchWorkItem2()
//dispatchWorkItem2.create()





//


var view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 528))
var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 320, height: 528))
imageView.backgroundColor = .systemPink

imageView.contentMode = .scaleAspectFit

view.addSubview(imageView)


PlaygroundPage.current.liveView = view


let urlString = "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"
let imageURL = URL(string: urlString)!


 //MARK:  Classic Image Load


func fetchImage(){
    let queue = DispatchQueue.global(qos: .utility)
    
    queue.async {
        if let data = try? Data(contentsOf: imageURL){
            
            DispatchQueue.main.async {
            imageView.image = UIImage(data: data)
            }
        }
    }
}

//fetchImage()



 //MARK: Dispatch WorkItem


func fetchImage2(){
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInteractive) {
        data = try? Data(contentsOf: imageURL)
    }
    
    
    
    
}

