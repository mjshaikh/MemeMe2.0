//
//  MemeDetailViewController.swift
//  MemeMe2.0
//
//  Created by Mohammed Javeed Shaikh on 2016-02-03.
//  Copyright © 2016 Zaytun Lab. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController, EditMemeDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editMeme")
        
        if let meme = meme {
            imageView.image = meme.memedImage
        }
    }
    
    
    /* This function passes the current meme to MemeEditorVC and makes itself delegate to the property
        editMemeDelegate of MemeEditorVC */
    
    func editMeme() {
        
        let memeEditorVC = self.storyboard?.instantiateViewControllerWithIdentifier("memeEditorView") as! MemeEditorViewController
        
        memeEditorVC.receivedMeme = meme
        
        memeEditorVC.editMemeDelegate = self
        
        self.presentViewController(memeEditorVC, animated: true, completion: nil)
    }
    
    
    // Implementing delegate method to navigate to RootViewController when we are done from MemeEditorVC
    
    func navigateToRootViewController() {
     
        navigationController?.popViewControllerAnimated(true)
    }
    
}

/* Protocol which will be used for messaging between two View Controllers. The MemeEditorVC informs
    MemeDetailVC that editing has finished and the current MemeDetailVC should pop back to root view controller */

protocol EditMemeDelegate {
    
    func navigateToRootViewController()
}



