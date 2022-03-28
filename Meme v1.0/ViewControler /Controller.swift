//
//  Controller.swift
//  Meme v1.0
//
//  Created by Aleksandrs Trubacs on 04/02/2022.
//

import Foundation
import UIKit

extension EditMemeViewController {
    
    //MARK: Methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // KeyBoard Management
    
    /// Subscribing and Unsubscribing to notifications about the keyboard appearing and disapearing
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardDisappearingNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Method to shift the view
    @objc func keyboardWillShow(_ notification:Notification) {

        if bottomTextField.isFirstResponder{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    // Method to get the keyboards size
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    // Preparing default for TextFields
    func prepareTextField(textField: UITextField, defaultText: String, delegate: UITextFieldDelegate) {
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.placeholder = defaultText
        textField.delegate = delegate
        textField.textAlignment = .center
    }
    
    
    //MARK: - Main Methods
    
    func save(memedImage: UIImage) {
        
        // Create the meme
        let meme = Meme(topCaption: topTextField.text!, bottomCaption: bottomTextField.text!, originalImage: imagePickerView.image!, editedImage: memedImage)
        
        // Adding to the meme array
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
  
    func generateMemedImage() -> UIImage {
        // Hiding Nav and Tool bars
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Showing Nav and Tool bars
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.isNavigationBarHidden = false
        
        return memedImage
    }
    
    
}
