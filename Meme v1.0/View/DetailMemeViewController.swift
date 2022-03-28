//
//  DetailMemeViewController.swift
//  Meme v1.0
//
//  Created by Aleksandrs Trubacs on 27/03/2022.
//

import UIKit

class DetailMemeViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var memeView: UIImageView!
    
    //MARK: Properties
    
    var meme: Meme!
    
    
    //MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        memeView.image = meme.editedImage
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
    }
    
    
    
  

}
