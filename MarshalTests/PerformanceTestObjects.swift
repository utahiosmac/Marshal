//
//  TestObjects.swift
//  Marshal
//
//  Created by J. B. Whiteley on 4/23/16.
//  Copyright © 2016 Utah iOS & Mac. All rights reserved.
//

import Foundation
import Marshal

struct Recording : Unmarshaling {
    enum Status:String {
        case None = "0"
        case Recorded = "-3"
        case Recording = "-2"
        case Unknown
    }
    
    enum RecGroup: String {
        case Deleted = "Deleted"
        case Default = "Default"
        case LiveTV = "LiveTV"
        case Unknown
    }
    
    // Date parsing is slow. Remove them so performance can focus on JSON mapping.
    //let startTs:NSDate?
    //let endTs:NSDate?
    let startTsStr:String
    let status:Status
    let recordId:String
    let recGroup:RecGroup
    
    init(object json:MarshaledObject) throws {
        //startTs = try? json.valueForKey("StartTs")
        //endTs = try? json.valueForKey("EndTs")
        startTsStr = try json.valueForKey("StartTs")
        recordId = try json.valueForKey("RecordId")
        status = (try? json.valueForKey("Status")) ?? .Unknown
        recGroup = (try? json.valueForKey("RecGroup")) ?? .Unknown
    }
}

struct Program : Unmarshaling {
    
    let title:String
    let chanId:String
    //let startTime:NSDate
    //let endTime:NSDate
    let description:String?
    let subtitle:String?
    let recording:Recording
    let season:Int?
    let episode:Int?
    
    init(object json: MarshaledObject) throws {
        try self.init(jsonObj:json)
    }
    
    init(jsonObj:MarshaledObject, channelId:String? = nil) throws {
        let json = jsonObj
        title = try json.valueForKey("Title")
        
        if let channelId = channelId {
            self.chanId = channelId
        }
        else {
            chanId = try json.valueForKey("Channel.ChanId")
        }
        //startTime = try json.valueForKey("StartTime")
        //endTime = try json.valueForKey("EndTime")
        description = try json.valueForKey("Description")
        subtitle = try json.valueForKey("SubTitle")
        recording = try json.valueForKey("Recording")
        season = (try json.valueForKey("Season") as String?).flatMap({Int($0)})
        episode = (try json.valueForKey("Episode") as String?).flatMap({Int($0)})
    }
}

extension NSDate : ValueType {
    public static func value(object: Any) throws -> NSDate {
        guard let dateString = object as? String else {
            throw Error.TypeMismatch(expected: String.self, actual: object.dynamicType)
        }
        guard let date = NSDate.fromISO8601String(dateString) else {
            throw Error.TypeMismatch(expected: "ISO8601 date string", actual: dateString)
        }
        return date
    }
}

extension NSDate {
    static private let ISO8601MillisecondFormatter:NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
        let tz = NSTimeZone(abbreviation:"GMT")
        formatter.timeZone = tz
        return formatter
    }()
    static private let ISO8601SecondFormatter:NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
        let tz = NSTimeZone(abbreviation:"GMT")
        formatter.timeZone = tz
        return formatter
    }()
    
    static private let formatters = [ISO8601MillisecondFormatter,
                                     ISO8601SecondFormatter]
    
    static func fromISO8601String(dateString:String) -> NSDate? {
        for formatter in formatters {
            if let date = formatter.dateFromString(dateString) {
                return date
            }
        }
        return .None
    }
}

