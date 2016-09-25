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
        
//        print("\n\n\n" + String(FIRAuth.auth()?.currentUser?.uid) + "\n\n\n")
        
        GIDSignIn.sharedInstance().signInSilently()
        if FIRAuth.auth()?.currentUser != nil {
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.performSegueWithIdentifier("finish_signin", sender: self)
            }
        }
    }
    
}
