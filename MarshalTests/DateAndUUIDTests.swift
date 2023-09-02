//
//  DateAndUUIDTests.swift
//
//  Created by Rick Mann on 2021-05-18.
//

import Foundation

import XCTest
import Marshal



class
TestMarshalAdditions : XCTestCase
{
	func
	testDateFromMilliseconds()
		throws
	{
		let json: [String:Any] =
		[
			"dateInt" : 1621391590892,
			"dateDouble" : 1621391590892.0,
			"dateString" : "1621391590892",
			"notADate" : "pizza",
		]
		let dateInt: Date = try json.value(for: "dateInt", dateEncoding: .millisecondsSince1970)
		let dateDouble: Date = try json.value(for: "dateDouble", dateEncoding: .millisecondsSince1970)
		let dateString: Date = try json.value(for: "dateString", dateEncoding: .millisecondsSince1970)
		XCTAssertEqual(dateInt, Date(timeIntervalSince1970: 1621391590.892))
		XCTAssertEqual(dateDouble, Date(timeIntervalSince1970: 1621391590.892))
		XCTAssertEqual(dateString, Date(timeIntervalSince1970: 1621391590.892))
		
		let notADate: Date? = try? json.value(for: "notADate", dateEncoding: .millisecondsSince1970)
		XCTAssertNil(notADate)
		
		XCTAssertThrowsError(try json.value(for: "notADate", dateEncoding: .millisecondsSince1970))
	}
	
	func
	testDateFromSeconds()
		throws
	{
		let json: [String:Any] =
		[
			"dateInt" : 1621391590,
			"dateDouble" : 1621391590.0,
			"dateString" : "1621391590",
			"notADate" : "pizza",
		]
		let dateInt: Date = try json.value(for: "dateInt", dateEncoding: .secondsSince1970)
		let dateDouble: Date = try json.value(for: "dateDouble", dateEncoding: .secondsSince1970)
		let dateString: Date = try json.value(for: "dateString", dateEncoding: .secondsSince1970)
		XCTAssertEqual(dateInt, Date(timeIntervalSince1970: 1621391590))
		XCTAssertEqual(dateDouble, Date(timeIntervalSince1970: 1621391590))
		XCTAssertEqual(dateString, Date(timeIntervalSince1970: 1621391590))
		
		let notADate: Date? = try? json.value(for: "notADate", dateEncoding: .secondsSince1970)
		XCTAssertNil(notADate)
		
		XCTAssertThrowsError(try json.value(for: "notADate", dateEncoding: .secondsSince1970))
	}
	
	func
	testDateFromString()
		throws
	{
		let json: [String:Any] =
		[
			"createdAt" : "Tue, 25 May 2021 05:21:16 GMT",
		]
		let createdAt: Date = try json.value(for: "createdAt", dateEncoding: .formatted("EEE, dd MMM yyyy HH:mm:ss ZZZ"))
		XCTAssertEqual(createdAt, Date(timeIntervalSinceReferenceDate: 643612876.0))
	}
	
	func
	testDateFromDateFormatter()
		throws
	{
		let json: [String:Any] =
		[
			"createdAt" : "Tue, 25 May 2021 05:21:16 GMT",
		]
		
		let df = DateFormatter()
		df.dateFormat = "EEE, dd MMM yyyy HH:mm:ss ZZZ"
		
		let createdAt: Date = try json.value(for: "createdAt", dateEncoding: .formatter(df))
		XCTAssertEqual(createdAt, Date(timeIntervalSinceReferenceDate: 643612876.0))
	}
}
