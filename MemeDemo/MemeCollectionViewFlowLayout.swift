//
//  MemeCollectionViewFlowLayout.swift
//  MemeMe2.0
//
//  Created by Mohammed Shaikh on 2016-01-21.
//  Copyright © 2016 Zaytun Lab. All rights reserved.
//

import UIKit

class MemeCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    
    /* This function is used to dynamically calculate the item size in collectionView based on available 
        screen space, orientation and device model  */
    
    override func prepareLayout() {
        super.prepareLayout()
        
        // Computed property to calculate cell size
        
        var cellSize: Int {
            
            let screenWidth = Int(collectionView!.bounds.size.width)
            let screenHeight = Int(collectionView!.bounds.size.height)
            let minInteritemSpacing = Int(minimumInteritemSpacing)
            let edgeInset = Int(sectionInset.left + sectionInset.right)
            
            if UIDevice.currentDevice().model == "iPad" {
                
                // Landscape orientation on iPad means we have 7 items per row
                if screenWidth >= screenHeight {
                    return (screenWidth - (6 * minInteritemSpacing) - edgeInset) / 7
                }
                else{   // Portrait orientation on iPad means we have 4 items per row
                    return (screenWidth - (3 * minInteritemSpacing) - edgeInset) / 4
                }
            }
            else{   // iPhone model
                if screenWidth >= screenHeight {  // Landscape orientation on iPhone we have 5 items per row
                    return (screenWidth - (4 * minInteritemSpacing) - edgeInset) / 5
                }
                else{   // Portrait orientation on iPhone we have 3 items per row
                    return (screenWidth - (2 * minInteritemSpacing) - edgeInset) / 3
                }
            }
        }
        

        itemSize = CGSizeMake(CGFloat(cellSize), CGFloat(cellSize))
        
    }
    
    
    /* This function allow us to invalidate layout upon screen rotation if the frame size changes */
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return !CGSizeEqualToSize(newBounds.size, collectionView!.frame.size)
    }
}


