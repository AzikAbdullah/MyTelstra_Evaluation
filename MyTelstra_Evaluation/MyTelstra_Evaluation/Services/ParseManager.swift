//
//  ParseManager.swift
//  MyTelstra_Evaluation
//
//  Created by N, Azik Abdullah (Cognizant) on 28/06/20.
//  Copyright © 2020 N, Azik Abdullah (Cognizant). All rights reserved.
//

import Foundation

class ParseManager {
    func parseResponseData(data:Data?,error: NSError?, completionHandler: @escaping (Facts?, NSError?) -> Void) {
        guard let data = data else {return}
        do {
            if let response = String(data: data, encoding: String.Encoding.ascii),
                let utfData = response.data(using: String.Encoding.utf8) {// Form valid json data to decode parsing
                let parsedFacts:Facts =  try JSONDecoder().decode(Facts.self, from: utfData)
                if error == nil {
                    completionHandler(parsedFacts, nil)
                } else {
                    completionHandler(nil,error as NSError?)
                }
            } else {
                completionHandler(nil,error as NSError?)
            }
        } catch let jsonErr {
            print("Error serializing json", jsonErr)
        }
    }
}
