//
//  ViewController.swift
//  Jotter
//
//  Created by Dan Shafman on 9/24/16.
//  Copyright © 2016 Dan Shafman. All rights reserved.
//

import UIKit
import ALCameraViewController
import Firebase

class EntryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var addNewCard: UIView!
    @IBOutlet weak var captureExisitngCard: UIView!
    @IBOutlet weak var settingsCard: UIView!
    @IBOutlet weak var myJotsCard: UIView!
    @IBOutlet weak var addNewCardButton: UIButton!
    @IBOutlet weak var captureExistingButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var myJotsButton: UIButton!
    
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var imagePicker: UIImagePickerController!
    var jotImage: UIImage?
    var refImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        try! FIRAuth.auth()?.signOut()
        setUpCardShadows()
        setUpButtons()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "add_new" {
            let destination = segue.destinationViewController as! JotTakenViewController
            destination.jotImage = self.jotImage
        } else if segue.identifier == "capture_existing" {
            let destination = segue.destinationViewController as! CaptureExistingViewController
            destination.refImage = self.refImage
        }
    }
    
    func setUpCardShadows() {
        addNewCard.layer.shadowPath = UIBezierPath(rect: CGRectMake(6, 4, addNewCard.bounds.width * 0.515, 196)).CGPath
        addNewCard.layer.shadowColor = UIColor.blackColor().CGColor
        addNewCard.layer.shadowOpacity = 1
        addNewCard.layer.shadowOffset = CGSize.zero
        addNewCard.layer.shadowRadius = 3
        
        captureExisitngCard.layer.shadowPath = UIBezierPath(rect: CGRectMake(6, 4, addNewCard.bounds.width * 0.515, 196)).CGPath
        captureExisitngCard.layer.shadowColor = UIColor.blackColor().CGColor
        captureExisitngCard.layer.shadowOpacity = 1
        captureExisitngCard.layer.shadowOffset = CGSize.zero
        captureExisitngCard.layer.shadowRadius = 3
        
        settingsCard.layer.shadowPath = UIBezierPath(rect: CGRectMake(6, 4, addNewCard.bounds.width * 0.515, 196)).CGPath
        settingsCard.layer.shadowColor = UIColor.blackColor().CGColor
        settingsCard.layer.shadowOpacity = 1
        settingsCard.layer.shadowOffset = CGSize.zero
        settingsCard.layer.shadowRadius = 3
        
        myJotsCard.layer.shadowPath = UIBezierPath(rect: CGRectMake(6, 4, addNewCard.bounds.width * 0.515, 196)).CGPath
        myJotsCard.layer.shadowColor = UIColor.blackColor().CGColor
        myJotsCard.layer.shadowOpacity = 1
        myJotsCard.layer.shadowOffset = CGSize.zero
        myJotsCard.layer.shadowRadius = 3
    }
    
    func setUpButtons() {
        addNewCardButton.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        addNewCardButton.tag = 0
        addNewCard.bringSubviewToFront(addNewCardButton)
        
        captureExistingButton.addTarget(self, action: #selector(capExistingPressed), forControlEvents: .TouchUpInside)
        captureExistingButton.tag = 1
        captureExisitngCard.bringSubviewToFront(captureExistingButton)
        
        settingsButton.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        settingsButton.tag = 2
        settingsCard.bringSubviewToFront(settingsButton)
        
        myJotsButton.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside)
        myJotsButton.tag = 3
        myJotsCard.bringSubviewToFront(myJotsButton)
    }

    func buttonPressed(sender: UIButton) {
        let cameraViewController = CameraViewController(croppingEnabled: true) { [weak self] image, asset in
            if image != nil {
                self?.jotImage = image
            }
            self?.dismissViewControllerAnimated(true) {
                if image != nil {
                    self?.performSegueWithIdentifier("add_new", sender: self)
                }
            }
        }
        presentViewController(cameraViewController, animated: true, completion: nil)
    }
    
    func capExistingPressed(sender: UIButton) {
        let cameraViewController = CameraViewController(croppingEnabled: true) { [weak self] image, asset in
            if image != nil {
                self?.refImage = image
            }
            self?.dismissViewControllerAnimated(true) {
                if image != nil {
                    self?.performSegueWithIdentifier("capture_existing", sender: self)
                }
            }
        }
        presentViewController(cameraViewController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func makeSegue() {
        self.performSegueWithIdentifier("add_new", sender: self)
    }
    
    @IBAction func goBackSegue(segue: UIStoryboardSegue) {}
    @IBAction func leaveCapExisSegue(segue: UIStoryboardSegue) {}

}

