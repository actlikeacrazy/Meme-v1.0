//
//  SentMemesTableViewController.swift
//  Meme v1.0
//
//  Created by Aleksandrs Trubacs on 22/03/2022.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
  
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up right Bar Button Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(presentMemeEditor))
    }
    
    
    // MARK: Table View Stabs
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell")!
        let meme = self.memes[indexPath.row]
        
        cell.textLabel?.text = meme.topCaption
        cell.imageView?.image = meme.editedImage
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailMemeViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    @objc func presentMemeEditor() {
           
        let editorController = self.storyboard!.instantiateViewController(withIdentifier: "memeEditor") as! EditMemeViewController
        self.navigationController!.pushViewController(editorController, animated: true)
       
       }

}
