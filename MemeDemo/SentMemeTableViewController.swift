//
//  SentMemeTableViewController.swift
//  MemeMe2.0
//
//  Created by Mohammed Shaikh on 2015-12-12.
//  Copyright © 2015 Zaytun Lab. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    /* This function configures our custom cell view in the table for each index path */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellView = tableView.dequeueReusableCellWithIdentifier("tableViewCell", forIndexPath: indexPath) as! MemeTableViewCell
        
        cellView.memeImageView.image = memes[indexPath.row].memedImage
        
        cellView.memeLabel.text = memes[indexPath.row].topText + "..." + memes[indexPath.row].bottomText
        
        return cellView
    }
    
    
    /* This function makes sure we have fixed height for each row in the table */
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 125.0
    }
    
    
    /* This function is called when a cell is clicked and we load the detailViewController to show the meme */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("detailViewController") as! MemeDetailViewController
        
        detailViewController.meme = memes[indexPath.row]
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    /* This function implements swiping right to left feature to add delete functionality to the table */
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Update our meme array model by removing the item at selected row
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.removeAtIndex(indexPath.row)
        
        //Delete the row from the table at the indexPath
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
}
