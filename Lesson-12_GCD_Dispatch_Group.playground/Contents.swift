
// LESSON 12 - GCD Dispatch Group

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true



// SYNC
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



// ASYNC
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
//dispatchGroupTest2.loadInfo()









class EightImage: UIView{
    
    public var imageViews = [UIImageView]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        
        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        imageViews.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        for i in 0...7{
            imageViews[i].contentMode = .scaleAspectFit
            addSubview(imageViews[i])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


var view = EightImage(frame: CGRect(x: 0, y: 0, width: 700, height: 900))
view.backgroundColor = .red


let urlStrings = ["https://cdn.cnn.com/cnnnext/dam/assets/201030094143-stock-rhodesian-ridgeback-exlarge-169.jpg", "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png", "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg","https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"]

var images = [UIImage]()

PlaygroundPage.current.liveView = view




func asyncLoadImage(imageURL: URL,
                    runQueue: DispatchQueue,
                    completionQueue: DispatchQueue,
                    competion: @escaping (UIImage?, Error?)->Void){
    
    
    runQueue.async {
        do{
            let data = try Data(contentsOf: imageURL)
            completionQueue.async {
                competion(UIImage(data: data), nil)
            }
        }catch{
            
            
        }
    }
    
}
