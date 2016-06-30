//
//  M A R S H A L
//
//       ()
//       /\
//  ()--'  '--()
//    `.    .'
//     / .. \
//    ()'  '()
//
//

import XCTest
@testable import Marshal

class MarshalTests: XCTestCase {
    
    let object: MarshalDictionary = ["bigNumber": NSNumber(value: 10_000_000_000_000), "foo" : (2 as NSNumber), "str": "Hello, World!", "array" : [1,2,3,4,7], "object": ["foo" : (3 as NSNumber), "str": "Hello, World!"], "url":"http://apple.com",  "junk":"garbage", "urls":["http://apple.com", "http://github.com"]]
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasics() {
        self.measure {
            let str: String = try! self.object.valueForKey("str")
            XCTAssertEqual(str, "Hello, World!")
            //    var foo1: String = try object.valueForKey("foo")
            let foo2: Int = try! self.object.valueForKey("foo")
            XCTAssertEqual(foo2, 2)
            let bigNumber: Int64 = try! self.object.valueForKey("bigNumber")
            XCTAssertEqual(bigNumber, 10_000_000_000_000)
            let foo3: Int? = try! self.object.valueForKey("foo")
            XCTAssertEqual(foo3, 2)
            let foo4: Int? = try! self.object.valueForKey("bar")
            XCTAssertEqual(foo4, .none)
            let arr: [Int] = try! self.object.valueForKey("array")
            XCTAssert(arr.count == 5)
            let obj: JSONObject = try! self.object.valueForKey("object")
            XCTAssert(obj.count == 2)
            let innerfoo: Int = try! obj.valueForKey("foo")
            XCTAssertEqual(innerfoo, 3)
            let innerfoo2: Int = try! self.object.valueForKey("object.foo")
            XCTAssertEqual(innerfoo2, 3)
            let url:URL = try! self.object.valueForKey("url")
            XCTAssertEqual(url.host, "apple.com")
            
            let expectation = self.expectation(withDescription: "error")
            do {
                let _:Int? = try self.object.valueForKey("junk")
            }
            catch {
                let jsonError = error as! Marshal.Error
                expectation.fulfill()
                guard case Marshal.Error.typeMismatchWithKey = jsonError else {
                    XCTFail("shouldn't get here")
                    return
                }
            }
            
            let urls:[URL] = try! self.object.valueForKey("urls")
            XCTAssertEqual(urls.first!.host, "apple.com")
            
            self.waitForExpectations(withTimeout: 1, handler: nil)
        }
    }
    
    func testOptionals() {
        var str:String = try! object <| "str"
        XCTAssertEqual(str, "Hello, World!")
        
        var optStr:String? = try! object <| "str"
        XCTAssertEqual(optStr, "Hello, World!")
        
        optStr = try! object <| "not found"
        XCTAssertEqual(optStr, .none)
        
        let ra:[Int] = try! object <| "array"
        XCTAssertEqual(ra[0], 1)
        
        var ora:[Int]? = try! object <| "array"
        XCTAssertEqual(ora![0], 1)
        
        ora = try! object <| "no key"
        XCTAssertNil(ora)
        
        let ex = self.expectation(withDescription: "not found")
        do {
            str = try object <| "not found"
        }
        catch {
            if case Marshal.Error.keyNotFound = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(withTimeout: 1, handler: nil)
    }
    
    func testErrors() {
        var expectation = self.expectation(withDescription: "not found")
        let str: String = try! self.object.valueForKey("str")
        XCTAssertEqual(str, "Hello, World!")
        do {
            let _:Int = try object.valueForKey("no key")
        }
        catch {
            if case Marshal.Error.keyNotFound = error {
                expectation.fulfill()
            }
        }
        
        expectation = self.expectation(withDescription: "key mismatch")
        do {
            let _:Int = try object.valueForKey("str")
        }
        catch {
            if case Marshal.Error.typeMismatchWithKey = error {
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(withTimeout: 1, handler: nil)
    }
    
    func testDicionary() {
        let path = Bundle(for: self.dynamicType).pathForResource("TestDictionary", ofType: "json")!
        var data = try! Data(contentsOf: URL(fileURLWithPath: path))
        var json:JSONObject = try! JSONParser.JSONObjectWithData(data)
        let url:URL = try! json.valueForKey("meta.next")
        XCTAssertEqual(url.host, "apple.com")
        var people:[JSONObject] = try! json.valueForKey("list")
        var person = people[0]
        let city:String = try! person.valueForKey("address.city")
        XCTAssertEqual(city, "Cupertino")
        
        data = try! json.jsonData()
        
        json = try! JSONParser.JSONObjectWithData(data)
        people = try! json.valueForKey("list")
        person = people[1]
        let dead = try! !person.valueForKey("living")
        XCTAssertTrue(dead)
    }
    
    func testSimpleArray() {
        let path = Bundle(for: self.dynamicType).pathForResource("TestSimpleArray", ofType: "json")!
        var data = try! Data(contentsOf: URL(fileURLWithPath: path))
        var ra = try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyObject]
        XCTAssertEqual(ra.first as? Int, 1)
        XCTAssertEqual(ra.last as? String, "home")
        
        data = try! ra.jsonData()
        ra = try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyObject]
        XCTAssertEqual(ra.first as? Int, 1)
        XCTAssertEqual(ra.last as? String, "home")
    }
    
    func testObjectArray() {
        let path = Bundle(for: self.dynamicType).pathForResource("TestObjectArray", ofType: "json")!
        var data = try! Data(contentsOf: URL(fileURLWithPath: path))
        var ra:[JSONObject] = try! JSONParser.JSONArrayWithData(data)
        
        var obj:JSONObject = ra[0]
        XCTAssertEqual(try! obj.valueForKey("n") as Int, 1)
        XCTAssertEqual(try! obj.valueForKey("str") as String, "hello")
        
        data = try! ra.jsonData()
        
        ra = try! JSONParser.JSONArrayWithData(data)
        obj = ra[1]
        XCTAssertEqual(try! obj.valueForKey("str") as String, "world")
    }
    
    func testNested() {
        let dict = ["type": "connected",
                    "payload": [
                        "team": [
                            "id": "teamId",
                            "name": "teamName"
                        ]
            ]
        ]
        
        let teamId:String = try! dict.valueForKey("payload.team.id")
        XCTAssertEqual(teamId, "teamId")
    }
    
    func testCustomObjects() {
        let path = Bundle(for: self.dynamicType).pathForResource("People", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let obj = try! JSONParser.JSONObjectWithData(data)
        let people:[Person] = try! obj.valueForKey("people")
        let person:Person = try! obj.valueForKey("person")
        XCTAssertEqual(people.first!.firstName, "Jason")
        XCTAssertEqual(person.firstName, "Jason")
        XCTAssertEqual(person.score, 42)
        XCTAssertEqual(people.last!.address!.city, "Cupertino")
    }
    
    enum MyEnum:String {
        case One
        case Two
        case Three
        
    }
    
    enum MyIntEnum:Int {
        case one = 1
        case two = 2
    }
    
    
    func testEnum() {
        let json = ["one":"One", "two":"Two", "three":"Three", "four":"Junk", "iOne":NSNumber(value: 1), "iTwo":NSNumber(value: 2)]
        let one:MyEnum = try! json.valueForKey("one")
        XCTAssertEqual(one, MyEnum.One)
        let two:MyEnum = try! json.valueForKey("two")
        XCTAssertEqual(two, MyEnum.Two)
        
        let nope:MyEnum? = try! json.valueForKey("junk")
        XCTAssertEqual(nope, .none)
        
        let expectation = self.expectation(withDescription: "enum test")
        do {
            let _:MyEnum = try json.valueForKey("four")
        }
        catch {
            expectation.fulfill()
        }
        waitForExpectations(withTimeout: 5, handler: nil)
        
        let iOne:MyIntEnum = try! json.valueForKey("iOne")
        XCTAssertEqual(iOne, MyIntEnum.one)
        
    }
    

    func testSet() {
        let path = Bundle(for: self.dynamicType).pathForResource("TestSimpleSet", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! JSONObject
        
        let first:Set<Int> = try! json.valueForKey("first")
        XCTAssertEqual(first.count, 5)
        let second:Set<Int> = try! json.valueForKey("second")
        XCTAssertEqual(second.count, 5)
        
        let nope:Set<Int>? = try! json.valueForKey("junk")
        XCTAssertEqual(nope, .none)
    }
    
    func testSwiftBasicTypes() {
        let object: MarshalDictionary = ["int8": NSNumber(value: 100), "int16": NSNumber(value: 32_000), "int32": NSNumber(value: 2_100_000_000), "int64": NSNumber(value: 9_000_000_000_000_000_000)]

        let int8: Int8 = try! object.valueForKey("int8")
        XCTAssertEqual(int8, 100)
        let int16: Int16 = try! object.valueForKey("int16")
        XCTAssertEqual(int16, 32_000)
        let int32: Int32 = try! object.valueForKey("int32")
        XCTAssertEqual(int32, 2_100_000_000)
        let int64: Int64 = try! object.valueForKey("int64")
        XCTAssertEqual(int64, 9_000_000_000_000_000_000)
        
        
        let soBig: UInt64 = 18_000_000_000_000_000_000
        let unsigned: MarshalDictionary = ["uint8": NSNumber(value: 200), "uint16": NSNumber(value: 65_000), "uint32": NSNumber(value: 4_200_000_000), "uint64": NSNumber(value: soBig), "char": "S"]
        
        let uint8: UInt8 = try! unsigned.valueForKey("uint8")
        XCTAssertEqual(uint8, 200)
        let uint16: UInt16 = try! unsigned.valueForKey("uint16")
        XCTAssertEqual(uint16, 65_000)
        let uint32: UInt32 = try! unsigned.valueForKey("uint32")
        XCTAssertEqual(uint32, 4_200_000_000)
        let uint64: UInt64 = try! unsigned.valueForKey("uint64")
        XCTAssertEqual(uint64, 18_000_000_000_000_000_000)
        
        let char: Character = try! unsigned.valueForKey("char")
        XCTAssertEqual(char, "S")
    }
}

struct Address: Unmarshaling {
    let street:String
    let city:String
    init(object json: MarshaledObject) throws {
        street = try json.valueForKey("street")
        city = try json.valueForKey("city")
    }
}

struct Person: Unmarshaling {
    let firstName:String
    let lastName:String
    let score:Int
    let address:Address?
    init(object json: MarshaledObject) throws {
        firstName = try json.valueForKey("first")
        lastName = try json.valueForKey("last")
        score = try json.valueForKey("score")
        address = try json.valueForKey("address")
    }
}
