//
//  ViewController.swift
//  Camera Application
//
//  Created by Angela on 4/12/15.
//  Copyright © 2015年 app.cs.hku. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,  UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func chooseImageFromPhotoLibrary(){
        let picker = UIImagePickerController()
        picker.delegate = self;
        picker.sourceType =  .PhotoLibrary
        presentViewController(picker,animated:true,completion:nil)
    }
    @IBAction func chooseImageFromCamera(){
        let imagePicker = UIImagePickerController()
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                NSLog("Application cannot access the camera.")
            }
        } else {
            NSLog("Application cannot access the camera.")
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // your code
        //imageView.image = info[UIImagePickerControllerOriginalImage] as UIImage
        //dismissViewControllerAnimated(true, completion: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = selectedImage
        let imageData = UIImagePNGRepresentation(selectedImage)
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let imageURL = documentsURL.URLByAppendingPathComponent("cached.png")
        let urlString = imageURL.absoluteString
        if !imageData!.writeToURL(imageURL, atomically: false)
        {
            print("not saved")
        } else {
            print("saved")
            NSUserDefaults.standardUserDefaults().setObject(urlString, forKey: "imagePath")
        }
    }
    
    
}
