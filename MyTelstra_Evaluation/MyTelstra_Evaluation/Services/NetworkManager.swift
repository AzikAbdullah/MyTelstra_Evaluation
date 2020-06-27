//
//  NetworkManager.swift
//  MyTelstra_Evaluation
//
//  Created by N, Azik Abdullah (Cognizant) on 27/06/20.
//  Copyright © 2020 N, Azik Abdullah (Cognizant). All rights reserved.
//

import Foundation

class NetworkManager {
    func fetchJsonData(_ urlString: String, completionHandler: @escaping (Facts?, NSError?) -> Void) {
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { (data, _, error) in
            guard let data = data else {return}
            do {
                if let response = String(data: data, encoding: String.Encoding.ascii),
                    let utfData = response.data(using: String.Encoding.utf8) {
                    let parsedFacts:Facts =  try JSONDecoder().decode(Facts.self, from: utfData)
                    if error == nil {
                        completionHandler(parsedFacts, nil)
                    } else {
                        completionHandler(nil,error as NSError?)
                    }
                }
                else {
                    completionHandler(nil,error as NSError?)
                }

            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        })
        task.resume()
    }
}
