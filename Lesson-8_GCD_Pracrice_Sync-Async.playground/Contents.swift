
// LESSON 7 - GCD Practice - Sync/Async

import UIKit
import PlaygroundSupport //helps to wait for threads



class MyViewController: UIViewController{
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc1"
        view.backgroundColor = .red
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initButton()
    }
    
    
    func initButton(){
        
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        button.center = view.center
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
    }

}


let vc = MyViewController()
let navBar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navBar
