//
//  UnmarshalingWithContextTests.swift
//  Marshal
//
//  Created by Bart Whiteley on 5/27/16.
//  Copyright © 2016 Utah iOS & Mac. All rights reserved.
//

import XCTest
import Marshal

class UnmarshalingWithContextTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testObjectMapping() {
        let obj = personsJSON()
        let context = DeserializationContext()
        let people:[Person] = try! obj.valueForKey("people", context:context)
        let person:Person = try! obj.valueForKey("person", context:context)
        XCTAssertEqual(people.first!.firstName, "Jason")
        XCTAssertEqual(person.firstName, "Jason")
        XCTAssertEqual(person.score, 42)
        XCTAssertEqual(people.last!.address!.city, "Cupertino")
    }
    
    func testObjectMappingErrors() {
        let obj = personsJSON()
        let context = DeserializationContext()
        
        let nPerson:AgedPerson? = try! obj.valueForKey("person", context:context)
        XCTAssertNil(nPerson)
        
        let expectation = self.expectationWithDescription("error test")
        do {
            let _:AgedPerson = try obj.valueForKey("person", context:context)
        }
        catch {
            if case Error.KeyNotFound = error {
                expectation.fulfill()
            }
        }
        
        let expectation2 = self.expectationWithDescription("error test for array")
        do {
            let _:[AgedPerson] = try obj.valueForKey("persons", context:context)
        }
        catch {
            if case Error.KeyNotFound = error {
                expectation2.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    private func personsJSON() -> JSONObject {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("People", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        return try! JSONParser.JSONObjectWithData(data)
    }

}

private struct Address {
    var street:String!
    var city:String!
}

extension Address: UnmarshalUpdating {
    private mutating func update(object object: MarshaledObject) throws {
        street = try object.valueForKey("street")
        city = try object.valueForKey("city")
    }
}

extension Address: UnmarshalingWithContext {
    private static func valueFromObject(object: MarshaledObject, context:DeserializationContext) throws -> Address {
        var address = context.newAddress()
        try address.update(object: object)
        return address
    }
}

private struct Person {
    var firstName:String!
    var lastName:String!
    var score:Int!
    var address:Address?
}

extension Person: UnmarshalUpdatingWithContext {
    private mutating func update(object object: MarshaledObject, context:DeserializationContext) throws {
        firstName = try object.valueForKey("first")
        lastName = try object.valueForKey("last")
        score = try object.valueForKey("score")
        address = try object.valueForKey("address", context:context)
    }
}

extension Person: UnmarshalingWithContext {
    private static func valueFromObject(object: MarshaledObject, context:DeserializationContext) throws -> Person {
        var person = context.newPerson()
        try person.update(object: object, context: context)
        return person
    }
}

private struct AgedPerson {
    var age:Int = 0
}

extension AgedPerson: UnmarshalingWithContext {
    private static func valueFromObject(object: MarshaledObject, context: DeserializationContext) throws -> AgedPerson {
        var person = context.newAgedPerson()
        person.age = try object.valueForKey("age")
        return person
    }
}

private class DeserializationContext {
    func newPerson() -> Person {
        return Person()
    }
    
    func newAddress() -> Address {
        return Address()
    }
    
    func newAgedPerson() -> AgedPerson {
        return AgedPerson()
    }
}
