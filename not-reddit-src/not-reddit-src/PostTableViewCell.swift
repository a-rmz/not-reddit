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
    func reload()
}

class PostTableViewCell: UITableViewCell {
    
    let session: Session = NotSession.sharedSession.session!
    
    var delegate: askForLogin!
    
    var name: String = String()
    
    @IBOutlet weak var saveButton: UIButton!

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

   
    @IBAction func savePost(_ sender: Any) {
        if NotSession.sharedSession.currentUser == nil {
            self.delegate.askForLogin()
        } else {
           
            
            if self.saveButton.imageView?.backgroundColor != UIColor.yellow {
                try? session.setSave(true, name: self.name, completion: { (result: Result<JSONAny>
                    ) in
                    print(result)
                    
                    self.saveButton.imageView?.backgroundColor = UIColor.yellow
                    self.delegate.reload()
                
                })
                
            }else {
                try? session.setSave(false, name: self.name, completion: { (result: Result<JSONAny>
                    ) in
                    
                    self.saveButton.imageView?.backgroundColor = UIColor.white
                    self.delegate.reload()
                    
                })
                
            }
            
            
            
        }
        
    }
   
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
            if self.buttonDown.imageView?.backgroundColor != UIColor.white {
            
            try? session.setVote(.up, name: self.name, completion: { (result: Result<JSONAny>
                ) in
                print("boton down encendido")
                self.buttonUp.imageView?.backgroundColor = UIColor.red
                self.buttonDown.imageView?.backgroundColor = UIColor.white
                self.delegate.reload()
            })
                
            }else if self.buttonUp.imageView?.backgroundColor != UIColor.red {
                try? session.setVote(.up, name: self.name, completion: { (result: Result<JSONAny>
                    ) in
                    print("boton rojo no encendido")
                    self.buttonUp.imageView?.backgroundColor = UIColor.red
                    self.delegate.reload()
                    
                })
                
            }else {
                try? session.setVote(.none, name: self.name, completion: { (result: Result<JSONAny>
                    ) in
                    print("boton rojo encendido")
                    self.buttonUp.imageView?.backgroundColor = UIColor.white
                    self.delegate.reload()
                })
            }
            
           
        }
     
        
    }
    
    func downvote() {
        if NotSession.sharedSession.currentUser == nil {
            self.delegate.askForLogin()
        } else {
            if self.buttonUp.imageView?.backgroundColor == UIColor.red{
                
                try? session.setVote(.down, name: self.name, completion: { (result: Result<JSONAny>
                    ) in
                    print("Boton rojo encendido")
                    self.buttonDown.imageView?.backgroundColor = UIColor.blue
                    self.buttonUp.imageView?.backgroundColor = UIColor.white
                    self.delegate.reload()
                })
                
            }else if self.buttonDown.imageView?.backgroundColor != UIColor.blue {
                try? session.setVote(.down, name: self.name, completion: { (result: Result<JSONAny>
                    ) in
                    print("Boton azul no encendido")
                    self.buttonDown.imageView?.backgroundColor = UIColor.blue
                    self.delegate.reload()
                })
                
            }else {
                try? session.setVote(.none, name: self.name, completion: { (result: Result<JSONAny>
                    ) in
                    print("Boton azul encendido")
                    self.buttonDown.imageView?.backgroundColor = UIColor.white
                    self.delegate.reload()
                })
            }
            
            
        }
        
    }
}
