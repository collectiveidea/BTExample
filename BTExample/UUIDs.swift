//
//  UUIDs.swift
//  BTExample
//
//  Created by Chris Rittersdorf on 5/2/19.
//  Copyright © 2019 Chris Rittersdorf. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol CBUUIDable {
    func toCBUUID() -> CBUUID
}

extension CBUUIDable {
    func toCBUUID() -> CBUUID {
        return CBUUID(string: self as! String)
    }
}

struct UUID {
    enum Service: String, CBUUIDable {
        case MLDP = "00035b03-58e6-07dd-021a-08123a000300"
        case Transparent = "49535343-fe7d-4ae5-8fa9-9fafd205e455"
    }

    enum CharacteristicUUID: String, CBUUIDable {
        case data = "00035b03-58e6-07dd-021a-08123a000301"
        case control = "00035b03-58e6-07dd-021a-08123a0003ff"
        case tx = "49535343-1e4d-4bd9-ba61-23c647249616"
        case rx = "49535343-8841-43f4-a8d4-ecbe34729bb3"
    }
}
