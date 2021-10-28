
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
    }
}



let dispatchGroupTest1 = DispatchGroupTest1()


dispatchGroupTest1.loadInfo()
