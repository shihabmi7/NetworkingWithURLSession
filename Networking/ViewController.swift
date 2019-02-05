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
    //    var getURL = "http://localhost:3000/posts"
    //    var postURL = "http://localhost:3000/posts"
    //var sharedSession : URLSession?
    var errorMessage = ""
    @IBOutlet weak var lableResponse: UILabel!
    let decoder = JSONDecoder()
    
    @IBOutlet weak var lablePostResponse: UILabel!

    var actors: [Actor] = []
    
    struct Actor: Codable {
        let title: String
        let author: String
        let id: Int
    }
    
    struct ActorPost: Codable {
        let title: String
        let author: String
    }
    
    struct Response: Codable {
        let  author : String
        let  title : String
        //let  id : Int

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageURL = "https://goo.gl/wV9G4I"
        let sharedSession = URLSession.shared
   
        if let url = URL(string: imageURL) {
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



     @IBAction func getActor() {
        let getDecoder = JSONDecoder()
        let getSession = URLSession(configuration: .default)
            if let url = URL(string: "http://localhost:3000/posts") {
            // create reuest
            let request = URLRequest(url: url)
            // create Data Task
            let dataTask = getSession.dataTask(with: request, completionHandler:{ (data, response, error) -> Void in
            
                if let error = error {
                    self.errorMessage += "Data Task Error" + error.localizedDescription + "\n"
                }  else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                    do {
                      let arrayData = try getDecoder.decode([Actor].self, from: data)
                        print("Result count: \(arrayData.count)")
                        for result in arrayData{
                            print("Name: \(result.author)")
                        }
                        
                        DispatchQueue.main.async {
                            self.lableResponse.text = ""
                            self.lableResponse.text = "\(arrayData.count)"

                        }
                     
                    } catch let decodeError as NSError{
                        print("getActor errorMessage:  " + decodeError.localizedDescription)
                        return
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

    @IBAction func makePostRequest(_ sender: Any) {
        
        let postSesson = URLSession(configuration: .ephemeral)
        if let url = URL(string: "http://localhost:3000/posts"){
            // create reuest
            var    request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json",forHTTPHeaderField:  "content-type")
            let encoder = JSONEncoder()
            let actor = ActorPost(title: "A rain drop", author:"Shihab Uddin")
            do {
                let data = try encoder.encode(actor)
                request.httpBody  = data
            } catch let encodeError as NSError {
                print("Encode Error \(encodeError.localizedDescription)")
            }
            
            // create Data Task
            let postTask = postSesson.dataTask(with: request, completionHandler:{ (data, response, error) -> Void in
                
                if let error = error {
                    
                    self.errorMessage += "Data Task Error" + error.localizedDescription + "\n"
                }  else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 201 {
                    
                    do {
                        
                        let response = try self.decoder.decode(Response.self, from: data)
                    
                        DispatchQueue.main.async {
                            //self.lablePostResponse.text = ""
                            self.lablePostResponse.text = response.title + " "+response.author
                            print(response.author)
                        }
                        
                    } catch {
                        print("errorMessage: in catch (post) "+error.localizedDescription)
                    }
                }
            })
            
            postTask.resume()
        }
    }
}


