//
//  ViewController.swift
//  OnTheMap
//
//  Created by Manuel Carvalho on 14/1/19.
//  Copyright © 2019 Manuel Carvalho. All rights reserved.
//

import UIKit

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func downloadData(){
        var request = URLRequest(url: URL(string: Constants.Parse.ParseBaseURL)!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            
            guard let data = data else {return}
            //print(String(data: data, encoding: .utf8)!)
            //let json = String(data: data!, encoding: .utf8)
            //self.jsonConvert(data: data)
            
            
            
            do{
                //                let udacity = try JSONDecoder().decode(Udacity.self, from: data)
                //                print(udacity.results.count)
                
                let myJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                
                if let students = myJson["results"] as! [NSDictionary]? {
                    //print("Students \(students.count)")
                    
                    for student in students {
                        let objectId = student["objectId"] as! String
                        //let uniqueKey = try! student["uniqueKey"] as! String
                        //let firstName = try! student["firstName"] as! String
                        //let lastName = try! student["lastName"] as! String
                        let mapString = student["mapString"] as! String
                        let mediaURL = student["mediaURL"] as! String
                        let latitude = student["latitude"] as! Double
                        let longitude = student["longitude"] as! Double
                        let createdAt = student["createdAt"] as! String
                        let updatedAt = student["updatedAt"] as! String
                        print(mapString)
                        
                        
                        
                        let newStudent = Student1(objectId: objectId, uniqueKey: " ", firstName: " ", lastName: " ", mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude, createdAt: createdAt, updatedAt: updatedAt)
                        
                        Model.udacity.append(newStudent)
                        print(Model.udacity.count)
                    }
                    
                    print(Model.udacity.count)
                }
                
                print(Model.udacity.count)
               
            } catch  _ {print("JSON error")}
        }
        task.resume()
    }
    
    


}

