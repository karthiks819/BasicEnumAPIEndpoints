//
//  ViewController.swift
//  EnumAPIHeaders
//
//  Created by Karthik on 04/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let getCall = Users.all(sort: .newest(.asc), limit: 10, last_id: 1)
        print(getCall.request)
        
        let posts: Posts = .all(sort: .newest(.desc), limit: 20, last_id: nil)
        print(posts.request)
        
        let task = URLSession.shared.dataTask(with: getCall.request){_,_,_ in
            // Do work
        }
        
        task.resume();
    }
    
    
}

