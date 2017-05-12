//
//  SaveTableViewCell.swift
//  not-reddit-src
//
//  Created by Emiliano García García on 12/05/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift


protocol askForReload {
    func reload()
}

class SaveTableViewCell: UITableViewCell {

    let session:Session = NotSession.sharedSession.session!
    
    var name:String = String()
    
    var delegate: askForReload!
    
    @IBOutlet weak var imageViewThumb: UIImageView!
    
    @IBOutlet weak var labelOP: UILabel!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func savePost(_ sender: Any) {
        
        if NotSession.sharedSession.currentUser == nil {
            self.delegate.reload()
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
    
    

}
