//
//  ViewController.swift
//  Meme v1.0
//
//  Created by Aleksandrs Trubacs on 23/01/2022.
//

import UIKit

class EditMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    
    let topTextFieldDelegate = TopTextFieldDelegate()
    
    
   
    
    //MARK: Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    @IBAction func shareButton(_ sender: UIButton) {
        
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(controller, animated: true) {
            self.save(memedImage: memedImage)
        }
        
        
        controller.completionWithItemsHandler = {(_, completed, _, _) in
                if !completed {
                    return
                }
                // Enable the share button
                self.shareButton.isEnabled = false
                // User completed activity
                self.save(memedImage: memedImage)
                controller.dismiss(animated: true, completion: nil)
            }
        
        
    }
    
    
    @IBAction func cancelButton(_ sender: UIButton) {
        imagePickerView.image = nil
        topTextField.text = .none
        bottomTextField.text = .none
        
        self.shareButton.isEnabled = false
        
    }
    
    
    @IBAction func pickAnImageAlbum(_ sender: UIButton) {
       // Picking an Image from the photoAlubm
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        switch sender.tag {
        case 1:
            imagePicker.sourceType = .camera
        case 2:
            imagePicker.sourceType = .photoLibrary
        default:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true) {
            self.shareButton.isEnabled = true
        }
        
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.topTextField.delegate = topTextFieldDelegate
        self.bottomTextField.delegate = topTextFieldDelegate
        self.shareButton.isEnabled = false
        
        prepareTextField(textField: topTextField, defaultText:"TOP")
        prepareTextField(textField: bottomTextField, defaultText:"BOTTOM")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
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
        if imagePickerView.image != nil {
            _ = Meme(topCaption: topTextField.text!, bottomCaption: bottomTextField.text!, originalImage: imagePickerView.image!, editedImage: memedImage)
        }
        
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
  
    
    
    
}
