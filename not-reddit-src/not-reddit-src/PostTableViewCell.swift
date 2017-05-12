//
//  PostTableViewCell.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/23/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//
import reddift
import UIKit

protocol askForLogin {
    func askForLogin()
}

class PostTableViewCell: UITableViewCell {
    
    var delegate: askForLogin!

    @IBOutlet weak var buttonUp: UIButton!
    
    @IBOutlet weak var buttonDown: UIButton!
   
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelOp: UILabel!
    
    @IBOutlet weak var imageViewThumb: UIImageView!

    @IBOutlet weak var constraintImageHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

   
   
    @IBAction func actionVote(_ sender: UIButton) {
        
        
        switch sender.tag {
        case 1:
            upvote()
        case -1:
            downvote()
        default:
            break
        }
        
    }
    
    func upvote() {
        if NotSession.sharedSession.currentUser == nil {
            self.delegate.askForLogin()
        } else {
           buttonUp.imageView?.tintColor = UIColor.red
        }
        
    }
    
    func downvote() {
        if NotSession.sharedSession.currentUser == nil {
            self.delegate.askForLogin()
        } else {
            buttonUp.imageView?.tintColor = UIColor.red
        }
    }
}
