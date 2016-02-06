//
//  Meme.swift
//  MemeMe1.0
//
//  Created by Mohammed Shaikh on 2015-12-08.
//  Copyright © 2015 Zaytun Lab. All rights reserved.
//

import Foundation
import UIKit

struct Meme : Equatable {
    
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
}

// Function to check whether two memes are equal by checking the memed Image

func ==(lhs: Meme, rhs: Meme) -> Bool {
    return lhs.memedImage == rhs.memedImage
}