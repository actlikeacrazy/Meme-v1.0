//
//  CollectionViewController.swift
//  Meme v1.0
//
//  Created by Aleksandrs Trubacs on 22/03/2022.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //MARK: Properties
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
        
        self.tabBarController?.tabBar.isHidden = false
        //Collection View Flow properties
        
        let spacing: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * spacing)) / 3.0
        
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.minimumLineSpacing = spacing
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting up right Bar Button Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(presentMemeEditor))
    }
    
    // MARK: Collection View Stabs
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath) as! MemeCollectionCell
        let meme = self.memes[indexPath.row]
        
        cell.memeView.image = meme.editedImage
        cell.memeLabel.text = meme.topCaption
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailMemeViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
        
    }
    
    // MARK: Custom Methods
    
    
    @objc func presentMemeEditor() {
        
        let editorController = self.storyboard!.instantiateViewController(withIdentifier: "memeEditor") as! EditMemeViewController
        self.navigationController!.pushViewController(editorController, animated: true)
        
        
    }
    
}



