//
//  GoogleAuthViewController.swift
//  Jotter
//
//  Created by Dan Shafman on 9/25/16.
//  Copyright © 2016 Dan Shafman. All rights reserved.
//

import UIKit
import Firebase

class GoogleAuthViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
//        let ref = Firebase(url: "https://<YOUR-FIREBASE-APP>.firebaseio.com")
//        if ref.authData != nil {
//            // user authenticated
//            println(ref.authData)
//        } else {
//            // No user is signed in
//        }
        
        print("\n\n\n" + String(FIRAuth.auth()?.currentUser?.uid) + "\n\n\n")
        
//        GIDSignIn.sharedInstance().signInSilently()
        if FIRAuth.auth()?.currentUser != nil {
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.performSegueWithIdentifier("finish_signin", sender: self)
            }
        }
    }
    
}
