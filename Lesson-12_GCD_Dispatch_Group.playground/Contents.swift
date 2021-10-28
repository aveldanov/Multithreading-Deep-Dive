
// LESSON 12 - GCD Dispatch Group

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


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

let dispatchGroupTest1 = DispatchGroupTest1()
//dispatchGroupTest1.loadInfo()

class DispatchGroupTest2{
    
    
    
    private let queueConcurrent = DispatchQueue(label: "DispatchGroupQueue2", attributes: .concurrent)
    private let groupBlack = DispatchGroup()
    
    func loadInfo(){

        groupBlack.enter()
        queueConcurrent.async{
            sleep(1)
            print("1")
            self.groupBlack.leave()
        }
        groupBlack.enter()
        queueConcurrent.async {
            sleep(1)
            print("2")
            self.groupBlack.leave()
        }
    }
}

let dispatchGroupTest2 = DispatchGroupTest2()
