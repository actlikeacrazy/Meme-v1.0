//
//  ViewController.swift
//  Meme v1.0
//
//  Created by Aleksandrs Trubacs on 23/01/2022.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    
    let topTextFieldDelegate = TopTextFieldDelegate()
    
    
   
    
    //MARK: Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func shareButton(_ sender: UIButton) {
        
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(controller, animated: true) {
            self.save(memedImage: memedImage)
        }
    }
    
    
    @IBAction func cancelButton(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func pickAnImageAlbum(_ sender: Any) {
       // Picking an Image from the photoAlubm
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true) {
            self.enableShareButton()
        }
        
    }
    
    @IBAction func pickAnImageCamera(_ sender: Any) {
        
        // Picking an Image from the camera
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true) {
            self.enableShareButton()
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.topTextField.delegate = topTextFieldDelegate
        self.bottomTextField.delegate = topTextFieldDelegate
        
        enableShareButton()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Setting the textFields to have correct font, size and other attributes
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        
        // Disabling camera button if camera is not available
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
       
        
        super.viewWillAppear(animated)
        // Subscribing to keyboard notifications
        subscribeToKeyboardNotifications()
        subscribeToKeyboardDisappearingNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        // Unsubscribing from keyboard notifications
        unsubscribeFromKeyboardNotifications()
    }
    
    
    //MARK: Methods
    
    func save(memedImage: UIImage) {
            // Create the meme
        let meme = Meme(topCaption: topTextField.text!, bottomCaption: bottomTextField.text!, originalImage: imagePickerView.image!, editedImage: memedImage)
    }
    
    
    func generateMemedImage() -> UIImage {

        // TODO: Hide toolbar and navbar
        navigationController?.setToolbarHidden(true, animated: true)
        

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // TODO: Show toolbar and navbar
        navigationController?.setToolbarHidden(false, animated: true)
        
        
        return memedImage
    }
    
    func enableShareButton() {
        
        if imagePickerView.image != nil {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
        
    }
    
}

