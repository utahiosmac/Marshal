//
//  PerformanceTests.swift
//  Marshal
//
//  Created by J. B. Whiteley on 4/23/16.
//  Copyright © 2016 Utah iOS & Mac. All rights reserved.
//

import XCTest
import Marshal

class PerformanceTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeserialization() {
        self.measure {
            let d:NSDictionary = try! JSONSerialization.jsonObject(with: self.data, options: []) as! NSDictionary
            XCTAssert(d.count > 0)
        }
    }

    func testTypedDeserialization() {
        self.measure {
            let json = try! JSONParser.JSONObjectWithData(self.data)
            XCTAssert(json.count > 0)
        }
    }

    func testPerformance() {
        let json = try! JSONParser.JSONObjectWithData(data)

        self.measure {
            let programs:[Program] = try! json.valueForKey("ProgramList.Programs")
            XCTAssert(programs.count > 1000)
        }
    }
    
    private lazy var data:Data = {
        let path = Bundle(for: self.dynamicType).path(forResource: "Large", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        return data
    }()
}
