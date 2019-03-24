//
//  FeedViewController.swift
//  Social_Map
//
//  Created by Dillon Cain on 3/23/19.
//  Copyright © 2019 Cain Computers. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdd: UIImageView!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        imagePicker = UIImagePickerController()
        // Initializes imagePicker
        imagePicker.allowsEditing = true
        // Allows to crops and basic editing
        imagePicker.delegate = self
        
        // =====================================================================
        // Initializes listener
        DataService.ds.REF_POSTS.observe(.value) { (snapshot) in
            //print(snapshot.value)
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell {
            cell.configureCell(post: post)
            return cell
        } else {
            return PostTableViewCell()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageAdd.image = image
        } else {
            print("Dillon: A valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
        // Once image is selected gets rid of image picker
    }
    
    
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func signOutTapped(_ sender: Any) {
        // blank canvas... remove keychain and firebase id
        let keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Dillon: ID removed from keychain \(keyChainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
