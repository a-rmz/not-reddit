//
//  PostTableViewCell.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/23/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//
import reddift
import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonUp: UIButton!
    @IBOutlet weak var buttonDown: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelOP: UILabel!
    
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
        buttonUp.imageView?.tintColor = UIColor.red
    }
    
    func downvote() {
        
    }
}
