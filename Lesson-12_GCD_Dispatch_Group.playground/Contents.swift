
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
        
        groupBlack.wait()
        print("All finished")
        
        groupBlack.notify(queue: .main) {
            print("groupBlack finished all")

        }
    }
}

let dispatchGroupTest2 = DispatchGroupTest2()
dispatchGroupTest2.loadInfo()




class EightImage: UIView{
    
    public var images = [UIImageView]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        images.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        
        images.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        images.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        
        for i in 0...7{
            
            images[i].contentMode = .scaleAspectFit
            addSubview(images[i])
            
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
