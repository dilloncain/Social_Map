//
//  Post.swift
//  Social_Map
//
//  Created by Dillon Cain on 3/23/19.
//  Copyright © 2019 Cain Computers. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _username: String!
    
    var caption: String {
     return _caption
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
        return _postKey
    }
    
    var username: String {
        return _username
    }
    // Added username below -------------------------------\/
    init(caption: String, imageUrl: String, likes: Int, username: String) {
        self._caption = caption
        self._imageUrl = caption
        // caption in imageUrl?
        self._likes = likes
        self._username = username
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        // Possibly add username under users but for right now add under posts
        if let username = postData["username"] as? String {
            self._username = username
        }
        
    }
}
