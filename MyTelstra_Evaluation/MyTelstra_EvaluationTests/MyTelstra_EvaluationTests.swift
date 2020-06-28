//
//  MyTelstra_EvaluationTests.swift
//  MyTelstra_EvaluationTests
//
//  Created by N, Azik Abdullah (Cognizant) on 27/06/20.
//  Copyright © 2020 N, Azik Abdullah (Cognizant). All rights reserved.
//

import XCTest
@testable import MyTelstra_Evaluation

class MyTelstra_EvaluationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCancelServiceCall() {
        let serviceManager: NetworkManager! = NetworkManager()
        serviceManager.fetchJsonData(kServiceURL, completionHandler: { (_,_)  in
            
        })
        serviceManager.cancelServiceCall()
        XCTAssertNil(serviceManager.serviceTask, "Service call Stopped Successfully, returning nil value of service task")
    }
    
    func testEmptyURLServiceCall() {
        let serviceManager: NetworkManager! = NetworkManager()
        serviceManager.fetchJsonData("", completionHandler: { (dataResponse,error)  in
            XCTAssertNil(dataResponse, "Service call didn't happened and returned nil data")
        })
        
    }
    
    func testWrongURLServiceCall() {
        let serviceManager: NetworkManager! = NetworkManager()
        serviceManager.fetchJsonData("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/fs.json", completionHandler: { (dataResponse,error)  in
            XCTAssertNil(dataResponse, "Service call happened and returned nil data")
        })
        
    }
    
    func testSuccessFullServiceCall() {
        let serviceManager: NetworkManager! = NetworkManager()
        serviceManager.fetchJsonData(kServiceURL, completionHandler: { (dataResponse,error)  in
            if let factData = dataResponse {
                XCTAssertEqual(factData.title, "About Canada", "Service call happened and returned correct data")
            }
        })
    }
    
    func testEmptyDataParsing() {
        let parser:ParseManager! = ParseManager()
        let emptyData = Data()
        parser.parseResponseData(data: emptyData, error: nil, completionHandler: {(parsedData,error) in
            XCTAssertNil(parsedData, "Not crashed")
        })
    }


}
