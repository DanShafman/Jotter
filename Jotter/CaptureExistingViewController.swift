//
//  CaptureExistingViewController.swift
//  Jotter
//
//  Created by Dan Shafman on 9/25/16.
//  Copyright © 2016 Dan Shafman. All rights reserved.
//

import UIKit
import ALCameraViewController
import Firebase

class CaptureExistingViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var refImage: UIImage?
    var imagePicker: UIImagePickerController!
    
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    let metadata = FIRStorageMetadata()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = refImage
        let userName = FIRAuth.auth()?.currentUser?.uid
        let storage = FIRStorage.storage()
        var storageRef: FIRStorageReference = storage.referenceForURL("gs://jotter-70501.appspot.com")
        var imagesRef: FIRStorageReference = storageRef.child(String(UTF8String: (FIRAuth.auth()?.currentUser?.uid)!)! + "-ref")
        metadata.contentType = "image/jpeg"
        prefs.synchronize()
        let decoded  = prefs.objectForKey("interval") as! NSData
        var x = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! Int
        let fileName = "jot" + String(x)
        let jotImgRef = imagesRef.child(fileName)
        let imageData: NSData = UIImagePNGRepresentation(refImage!)!
        let pathName = (String(UTF8String: (FIRAuth.auth()?.currentUser?.uid)!)! + "-ref") + "/" + fileName
        
        let uploadTask = jotImgRef.putData(imageData, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL
            }
        }
    }
    
    func testJotIntervals() {
        prefs.synchronize()
        let decoded  = prefs.objectForKey("interval") as! NSData
        let x = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! Int
        print(x)
        print(refImage)
    }
    
}
