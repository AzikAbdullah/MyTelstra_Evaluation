//
//  Facts.swift
//  MyTelstra_Evaluation
//
//  Created by N, Azik Abdullah (Cognizant) on 27/06/20.
//  Copyright © 2020 N, Azik Abdullah (Cognizant). All rights reserved.
//

import Foundation

struct Facts: Decodable {//App Model designed for Service response
    let title: String?
    let rows: [FactContent]?
}

struct FactContent: Decodable {
    let title: String?
    let description: String?
    let imageHref: String?
}
