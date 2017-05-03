//
//  PostViewController.swift
//  not-reddit-src
//
//  Created by Emiliano García García on 02/05/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift
import Foundation

class PostViewController: UIViewController {
    
    var source: [reddift.Link] = []
    let session: Session = NotSession.sharedSession.session!
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var captchaImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //session.submitText(<#T##subreddit: Subreddit##Subreddit#>, title: <#T##String#>, text: <#T##String#>, captcha: <#T##String#>, captchaIden: <#T##String#>, completion: <#T##(Result<JSONAny>) -> Void#>)
        
        try? session.getIdenForNewCAPTCHA({(result) -> Void in
            switch result {
            case .failure:
                print(result.error?.description)
            case .success:
                if let string = result.value {
                    try? self.session.getCAPTCHA(string, completion: {(result) -> Void in
                        
                        switch result {
                        case .failure:
                            print(result.error?.description)
                        case .success:
                            if let image:CAPTCHAImage = result.value {
                                self.captchaImage.image = image
                            }
                            
                        }
                    
                    })
                }
            }
        
            
        })
        
        
        /*try? session.getCAPTCHA { (result: Result<CAPTCHAImage>) in
            self.captchaImage.image = result.value
        }*/
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
