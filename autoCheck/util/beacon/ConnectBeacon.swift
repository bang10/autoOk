//
//  connectBeacon.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/21.
//

import Foundation
import CoreLocation
import CoreBluetooth

class ConnectBeacon: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager!
    
    @Published var beaconDetected: Bool = false
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        startBeaconScanning()
    }
    
    private func startBeaconScanning() {
        let beaconUUID = UUID(uuidString: "e2c56db5-dffb-48d2-b060-d0f5a71096e0")
        let beaconRegion = CLBeaconRegion(uuid: beaconUUID!, major: 40011, minor: 34104,identifier: "MBeacon")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            beaconDetected = true
        } else {
            beaconDetected = false
        }
    }
}
