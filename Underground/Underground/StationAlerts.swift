//
//  StationAlerts.swift
//  Underground
//
//  Created by Joey Park on 12/3/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import UIKit

class StationAlerts: NSObject {
    var listOfAlerts : NSMutableArray = []
    private static var stationAlerts : StationAlerts?
    override init() {
        listOfAlerts = ["there is a track fire", "smoke has filled the station"]
    }
    public static func getInstance()->StationAlerts{
        if(self.stationAlerts == nil){
            self.stationAlerts = StationAlerts()
        }
        return self.stationAlerts!
    }
}
