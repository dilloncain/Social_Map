//
//  EventAnnotation.swift
//  Social_Map
//
//  Created by Dillon Cain on 3/24/19.
//  Copyright © 2019 Cain Computers. All rights reserved.
//

import Foundation
import MapKit

let events = [
    "wreck",
    "",
    ""
]

class EventAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var eventNumber: Int
    var eventName: String
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, eventNumber: Int) {
        self.coordinate = coordinate
        self.eventNumber = eventNumber
        self.eventName = events[eventNumber - 1].capitalized
        self.title = self.eventName
    }
    
}
