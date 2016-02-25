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

import Foundation
import Marshal

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

public extension NSDate {
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
