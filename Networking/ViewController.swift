//
//  ViewController.swift
//  Networking
//
//  Created by Raihan on 30/1/19.
//  Copyright © 2019 shihab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    let sharedSession = URLSession.shared
   
        if let url = URL(string: "https://goo.gl/wV9G4I"){
            // create reuest
            let request = URLRequest(url: url)
        
            // create Data Task
            
            let dataTask = sharedSession.dataTask(with: request, completionHandler:{ (data, response, error) -> Void in
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageview.image = image
                    }
                }
            })
            
            dataTask.resume()
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

