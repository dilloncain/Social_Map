//
//  SignInViewController.swift
//  Social_Map
//
//  Created by Dillon Cain on 3/21/19.
//  Copyright © 2019 Cain Computers. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import MapKit
import GeoFire

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        
        /*let loginButton = FBSDKLoginButton()
        // Optional: Place the button in the center of your view.
        loginButton.delegate = self as! FBSDKLoginButtonDelegate
        
        loginButton.center = view.center
        view.addSubview(loginButton) */
        
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Dillon: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("Dillon: User cancelled Facebook authentication")
            } else {
                print("Dillon: Sucessfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (user, error) in
            if error != nil {
                print("Dillon: Unable to authenticate with Firebase - \(error)")
            } else {
                print("Dillon: Successfully authenticated with Firebase")
            }
            // User is signed in
        })
    }
    
}
