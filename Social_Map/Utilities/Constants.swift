//
//  Constants.swift
//  Social_Map
//
//  Created by Dillon Cain on 3/21/19.
//  Copyright © 2019 Cain Computers. All rights reserved.
//

import UIKit

let  SHADOW_GRAY: CGFloat = 120.0 / 255.0

let KEY_UID = "uid"
// Flickr
let apiKey = "3b2cd2daf55831f4cce9e97ec61f19db"

func flickrUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(number)&format=json&nojsoncallback=1"
}
