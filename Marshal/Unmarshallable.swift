//
//  Unmarshallable.swift
//  Marshal
//
//  Created by Jason Larsen on 2/25/16.
//  Copyright © 2016 Utah iOS & Mac. All rights reserved.
//

import Foundation

public protocol Unmarshallable {
    func unmarshall() -> Object
}
