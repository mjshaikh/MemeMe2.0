//
//  SentMemeCollectionViewController.swift
//  MemeMe2.0
//
//  Created by Mohammed Shaikh on 2015-12-14.
//  Copyright © 2015 Zaytun Lab. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toggleSelectButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    // Computed property to store the index of collection view
    
    var selectedIndex = [NSIndexPath](){
        
        /* We use property observer to switch visibility of delete button when atleast one item is selected
            and added to selectedIndex array */
        
        didSet{
            if !selectedIndex.isEmpty{
                self.deleteButton.enabled = true
            }
            else{
                self.deleteButton.enabled = false
            }
        }
    }
    
    
    let selectButtonText = "Select"
    let cancelButtonText = "Cancel"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reload the contents of collectionView and toggle the visiblity of select button
        
        collectionView.reloadData()
        
        selectButtonVisibility()
    }
    
    
    /* This function switches the visibility of select button based on whether collectionView is empty or otherwise */
    
    func selectButtonVisibility() {
        
        if collectionView.numberOfItemsInSection(0) > 0 {
            toggleSelectButton.enabled = true
        }
        else{
            toggleSelectButton.enabled = false
            collectionView.allowsMultipleSelection = false
            toggleSelectButton.title = selectButtonText
        }
    }
    
    
    /* This function is called when Select button is clicked. The button act as a toggle between Selection and
        Canceling selection. This button activates muti-selection of items in collectionView which can be used
        to delete multiple items at once */
    
    @IBAction func toggleSelectButton(sender: UIBarButtonItem) {
        
        if collectionView.allowsMultipleSelection {
            collectionView.allowsMultipleSelection = false
            toggleSelectButton.title = selectButtonText
            
            // Deselect the selected items
            updateSelectedItems(delete: false)
        }
        else {
            collectionView.allowsMultipleSelection = true
            toggleSelectButton.title = cancelButtonText
        }
    }
    
    
    /* This function called when delete button is clicked to delete one ore more items. */
    
    @IBAction func deleteButton(sender: UIBarButtonItem) {

        // Delete the selected items
        updateSelectedItems(delete: true)
    }

    
    /* This functions uses a delete flag parameter to either delete the selected items or deselect and remove
        highlighting from the selected items */
    
    func updateSelectedItems(delete flag : Bool) {
        
        // Get a reference to AppDelegate and make a copy of memes array to manipulate our model
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let memesArray = appDelegate.memes
        
        
        for index in selectedIndex {
            
            if flag {   // If delete flag is true we find and delete the selected memes
                
                if let foundIndex = appDelegate.memes.indexOf(memesArray[index.row]){

                    // Update our meme model by removing the item at selected row
                    appDelegate.memes.removeAtIndex(foundIndex)
                }
            }
            
            // Deselect and remove highlighting for the item at specific index
            
            highlightItem(index, visible: false)
        }
        
        // Reload data in case the items were deleted, clear our selectedIndex array and switch select button visibility
        
        collectionView.reloadData()
        
        selectedIndex.removeAll()
        
        selectButtonVisibility()
    }
    
    
    /* This function uses a visible flag parameter to either highlight or unhighlight the item at specific index */
    
    func highlightItem(indexPath : NSIndexPath, visible: Bool) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if visible {
            cell!.layer.borderWidth = 3.0
            cell!.layer.borderColor = UIColor.orangeColor().CGColor
        } else {
            cell!.layer.borderWidth = 0
            cell!.layer.borderColor = nil
        }
    }
    
    
    /* Protocol functions of UICollectionViewDataSource and UICollectionViewDelegate class to bind our 
        data model to collectionView as well as responding to various events like item selection and deselection */
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Dequeue our custom MemeCollectionViewCell and set the image for each indexpath
        
        let cellView = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        cellView.memeImageView.image = memes[indexPath.row].memedImage
        
        return cellView
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // If multi-selection is enabled then mutiple items will be highlighted upon selection.
        
        if collectionView.allowsMultipleSelection {
            selectedIndex.append(indexPath)
            highlightItem(indexPath, visible: true)
        }
        else{   // Otherwise we present a detailViewController with memed image upon single selection
            
            let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("detailViewController") as! MemeDetailViewController
            
            detailViewController.meme = memes[indexPath.row]
            
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        // If multi-selection is enabled then mutiple items will be unhighlighted upon deselection.
        
        if collectionView.allowsMultipleSelection {

            if let foundIndex = selectedIndex.indexOf(indexPath) {
                selectedIndex.removeAtIndex(foundIndex)
            }
            
            highlightItem(indexPath, visible: false)
        }
    }
}
