//
//  Station.swift
//  Underground
//
//  Created by Joey Park on 11/27/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation
import MapKit
class Station: MKPointAnnotation {
    var comments : NSMutableArray = []
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
