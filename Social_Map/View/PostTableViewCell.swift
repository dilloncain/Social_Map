//
//  PostTableViewCell.swift
//  Social_Map
//
//  Created by Dillon Cain on 3/23/19.
//  Copyright © 2019 Cain Computers. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likeLabel: UILabel!

    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post: Post, img: UIImage? = nil) {  // If image is not present then dont pass image (uses default nil)
        self.post = post
        self.caption.text = post.caption
        self.likeLabel.text = "\(post.likes)"
        self.userNameLabel.text = "\(post.username)"
        
        //
        if img != nil {
            self.postImg.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.imageUrl)
            ref.getData(maxSize: 6 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Dillon: Unable to download image from Firebase storage")
                } else {
                    print("Dillon: Images downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedViewController.imageCache.setObject(img, forKey: post.imageUrl as NSString) // as NSString added here ** remove if error
                        }
                    }
                }
            })
        }
    }
    
}
