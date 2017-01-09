//
//  ViewControllerExtension.swift
//  AssessmentQ3
//
//  Created by LIN TINGMIN on 09/01/2017.
//  Copyright © 2017 MarkRobotDesignTEST. All rights reserved.
//

import UIKit
extension ViewController{
    func getRequest(){
        let url = URL(string: "https://httpbin.org/get")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("error:\(error?.localizedDescription)")
            }else{
                // change return data to json format
                let jsonData = try! JSONSerialization.jsonObject(with: data!)
                print("data\(jsonData)")
            }
        }
        task.resume()
    }
    func postRequest(){
        //prepare Json data
        let currentDate = Date()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateString = dateFormatter.string(from: currentDate)
        let postJson = ["time":currentDateString]
        let JsonToData = try! JSONSerialization.data(withJSONObject: postJson)
        
        //create post request
        let url = URL(string:"https://httpbin.org/post")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = JsonToData
        
        //create task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("error:\(error?.localizedDescription)")
            }else{
                let responseDate = Date()
                let calendar = Calendar.current
                let delaySeconds = calendar.compare(responseDate, to: currentDate, toGranularity: .second)
                print("花了\(delaySeconds.rawValue)秒")
                
            }
        }
        
        task.resume()
    }
}
