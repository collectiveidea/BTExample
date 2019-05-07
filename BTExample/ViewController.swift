//
//  ViewController.swift
//  BTExample
//
//  Created by Chris Rittersdorf on 5/2/19.
//  Copyright © 2019 Chris Rittersdorf. All rights reserved.
//

import Cocoa
import CoreBluetooth


class ViewController: NSViewController, CBPeripheralManagerDelegate {
    var mgr: CBPeripheralManager?
    let service = CBMutableService(
        type: CBUUID(string: "7DC4CC6E-208F-454A-A12E-2ADD755EEBF8"),
        primary: true
    )

    let characteristic = CBMutableCharacteristic(
        type: CBUUID(string: "5FBD1D69-9D56-4412-AE1B-81476568BCDE"),
        properties: .init(arrayLiteral: [.read]),
        value: "Hello".data(using: .utf8),
        permissions: [.readable]
    )
    
    let queue = DispatchQueue.global(qos: .background)
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("State updated")
        print(peripheral.state.rawValue)
        
        if peripheral.state == .poweredOn {
            mgr?.add(service)
            mgr?.startAdvertising([
                CBAdvertisementDataServiceUUIDsKey: [service.uuid]
            ])
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let descriptorUUID = CBUUID(string: CBUUIDCharacteristicUserDescriptionString)
        let descriptor = CBMutableDescriptor.init(type: descriptorUUID, value: "My val")
        characteristic.descriptors = [
            descriptor
        ]

        service.characteristics = [characteristic]
        
        
        mgr = CBPeripheralManager(delegate: self, queue: queue)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

