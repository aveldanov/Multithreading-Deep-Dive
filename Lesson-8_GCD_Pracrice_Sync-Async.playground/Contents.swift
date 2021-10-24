
// LESSON 7 - GCD Practice - Sync/Async

import UIKit
import PlaygroundSupport //helps to wait for threads



class MyViewController: UIViewController{
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc1"
        view.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initButton()
    }
    
    
    //MARK: Actions
    
    @objc func pressAction(){
        
        
        let vc = SecondViewController()
        vc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: Helpers
    func initButton(){
        
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        button.center = view.center
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
    }
    
}



class SecondViewController: UIViewController{
    
    
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc2"
        view.backgroundColor = .orange
        
        //        let urlString = "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"
        //
        //        let imageURL: URL = URL(string: urlString )!
        //
        //        if let data = try? Data(contentsOf: imageURL){
        //            print("BOOM", data)
        //                self.imageView.image = UIImage(data: data)
        //
        //            print(imageView.image)
        //        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initImage()
        
    }
    
    func initImage(){
        
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        view.addSubview(imageView)
    }
    
    func loadImage(){
        let urlString = "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"
        
        let imageURL: URL = URL(string: urlString )!
        let queue = DispatchQueue.global(qos: .utility)
        
        
    }
    
    
    
}


let vc = MyViewController()
let navBar = UINavigationController(rootViewController: vc)
navBar.view.frame = CGRect(x: 0, y: 0, width: 320, height: 568)

PlaygroundPage.current.liveView = navBar

