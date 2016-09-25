//
//  JotTakenViewController.swift
//  Jotter
//
//  Created by Dan Shafman on 9/25/16.
//  Copyright © 2016 Dan Shafman. All rights reserved.
//

import UIKit
import Firebase
import ALCameraViewController

class JotTakenViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var cameraSelector: UIButton!
    @IBOutlet weak var descText: UITextField!
    
    let storage = FIRStorage.storage()
    let metadata = FIRStorageMetadata()
    
    var num = 0
    
    var storageRef: FIRStorageReference {
        get {
            return storage.referenceForURL("gs://jotter-70501.appspot.com")
        }
    }
    var imagesRef: FIRStorageReference {
        get {
            return storageRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        }
    }

    var jotImage: UIImage?
    var cameraImage = UIImage(named: "camerabutton.png")
    
    override func viewDidLoad() {
        let userName = FIRAuth.auth()?.currentUser?.uid
        let uploadPath = FIRDatabase.database().reference().child("/"+userName!+"/currentImg")
        metadata.contentType = "image/jpeg"
//        let fileName = String(NSDate()) + ".jpg"
        let fileName = "jot" + 
        let jotImgRef = imagesRef.child(fileName)
        let imageData: NSData = UIImagePNGRepresentation(jotImage!)!
        let pathName = (FIRAuth.auth()?.currentUser?.uid)! + "/" + fileName
        
        uploadPath.setValue(NSString(string: pathName))
        imageDisplay.image = jotImage
        let uploadTask = jotImgRef.putData(imageData, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL
            }
        }
        
        cameraSelector.setImage(cameraImage, forState: .Normal)
        self.hideKeyboardWhenTappedAround()
        cameraSelector.addTarget(self, action: #selector(contentButtonPressed), forControlEvents: .TouchUpInside)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func contentButtonPressed() {
        let confirmString = descText.text!.stringByReplacingOccurrencesOfString(" ", withString: "")
        if confirmString != "" && descText.text != nil {
            
        } else {
            let alert = UIAlertController(title: "Input Error", message: "Please add a description to your label", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}