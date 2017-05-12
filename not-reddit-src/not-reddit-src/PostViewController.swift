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

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selftextTextView: UITextView!
    @IBOutlet weak var subPickerView: UIPickerView!
    @IBOutlet weak var captchaImage: UIImageView!
    @IBOutlet weak var captchaTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSubs()
        loadCaptcha()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCaptcha() {
        try? session.checkNeedsCAPTCHA { (needsCaptcha: Result<Bool>) in
            switch needsCaptcha {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let needs):
                if needs {
                    self.captchaImage.isHidden = false
                    self.captchaTextField.isHidden = false
                    try? self.session.getIdenForNewCAPTCHA({(result) -> Void in
                        switch result {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case .success(let captchaStr):
                            try? self.session.getCAPTCHA(captchaStr, completion: {(result) -> Void in
                                switch result {
                                case .failure(let err):
                                    print(err.localizedDescription)
                                case .success(let captcha):
                                    DispatchQueue.global().async {
                                        DispatchQueue.main.async {
                                            self.captchaImage.image = captcha
                                        }
                                    }
                                }
                                
                            })
                        }
                        
                    })
                }
            }
       }
    }
    
    func loadSubs() {
        try? self.session.getUserRelatedSubreddit(.subscriber, paginator: Paginator(), completion: { (result: Result<Listing>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                
                print("Hi")
            }
        })
    }

}

extension PostViewController : UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.source.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(String(component))
        return 1
    }
    
}








