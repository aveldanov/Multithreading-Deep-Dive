//
//  ViewController.swift
//  Lesson-9_GCD_AsyncAfter_ConcurrentPerform_InitiallyInactive
//
//  Created by Anton Veldanov on 10/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        afterBlock(seconds: 5, queue: .global()) {
        //            print("Hello")
        //            print(Thread.current)
        //        }
        
        
        afterBlock(seconds: 4) {
            print("Hello")
            DispatchQueue.main.async {
                self.showAlert()
            }
            print(Thread.current)
        }
    }
    
    
    
    func showAlert(){
        let alert = UIAlertController(title: "YES", message: "Message", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping ()->Void){
        
        // just passing completion IN
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completion()
        }
    }
}

