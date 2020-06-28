//
//  NetworkManager.swift
//  MyTelstra_Evaluation
//
//  Created by N, Azik Abdullah (Cognizant) on 27/06/20.
//  Copyright © 2020 N, Azik Abdullah (Cognizant). All rights reserved.
//

import Foundation

class NetworkManager {
    var serviceTask: URLSessionTask?
    
    func fetchJsonData(_ urlString: String, completionHandler: @escaping (Facts?, NSError?) -> Void) {
        cancelServiceCall()
        guard let servicURL = URL(string: urlString) else {
            completionHandler(nil,nil)
            return
        }
        var request = URLRequest(url: servicURL)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        serviceTask = session.dataTask(with: request, completionHandler: { (data, _, error) in
            ParseManager().parseResponseData(data: data, error: error as NSError?, completionHandler: completionHandler)
        })
        serviceTask?.resume()
    }
    
    func cancelServiceCall() {
        if let task = serviceTask {
            task.cancel()
        }
        serviceTask = nil
    }
    
    
}
