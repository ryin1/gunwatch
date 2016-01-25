//
//  ApiCenter.swift
//  policewatch5
//
//  Created by Joseph Gao on 1/24/16.
//  Copyright © 2016 Joseph Gao. All rights reserved.
//

import Foundation

class ApiCenter {
    
    func getReq(url: String) {
        let postEndpoint: String = "http://45.79.150.133:5000/"
        guard let url = NSURL(string: postEndpoint) else {
            print ("error")
            return 
        }
        let urlRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET")
                print(error)
                return
            }
            
            // parse result as JSON
            let post: NSDictionary
            do {
                post = try NSJSONSerialization.JSONObjectWithData(responseData, options: []) as! NSDictionary
            } catch {
                print("error trying to convert data to JSON")
                return
            }
            // have the post, print it
            print("The post is: "+post.description)
            print("The value is: "+(post["hello"] as! String))
            
        })
        task.resume()
    }
}