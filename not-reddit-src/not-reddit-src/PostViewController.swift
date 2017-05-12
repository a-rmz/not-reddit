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
    
    var source: [Subreddit] = []
    var selectedSub: Int = 0
    let session: Session = NotSession.sharedSession.session!
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selftextTextView: UITextView!
    @IBOutlet weak var subPickerView: UIPickerView!
    
    @IBAction func actionSubmit(_ sender: Any) {
        submitPost()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSubs()
        setupDataSource()
        setupDelegate()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submitPost() {
        let title: String = titleTextField.text!
        let text: String = selftextTextView.text!
        
        if (title.characters.count > 0 && text.characters.count > 0 && selectedSub >= 0) {
            let sub: Subreddit = source[selectedSub]
            
            try? self.session.submitText(sub, title: title, text: text, captcha: "", captchaIden: "", completion: {
                (r: Result<JSONAny>) in
                print(r)
                let json = r.value as! Dictionary<String, Any>
                let data = (json["json"] as! Dictionary<String, Any>)["data"]

                if data != nil {
                    self.showPostSuccess()
                } else {
                    self.showSomethingWrongAlert()
                }
                
                DispatchQueue.main.async {
                    self.titleTextField.text = ""
                    self.selftextTextView.text = ""
                }
            })
        } else {
            DispatchQueue.main.async {
                self.showIncompleteAlert()
            }
        }
        
    }
    
    func loadSubs() {
        try? self.session.getUserRelatedSubreddit(.subscriber, paginator: Paginator(), completion: { (result: Result<Listing>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
               let child = response.children as! [Subreddit]
                self.source = child
               DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.subPickerView.reloadAllComponents()
                }
               }
            }
        })
    }
    
    func showSomethingWrongAlert() {
        let alert = UIAlertController(
            title: "Oops! Something went wrong",
            message: "Please try again later",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in
        }
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showIncompleteAlert() {
        let alert = UIAlertController(
            title: "Something's incomplete",
            message: "Make sure you fill all the fields",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in
        }
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showPostSuccess() {
        let alert = UIAlertController(
            title: "Yah! 🎉",
            message: "Your post was submitted successfully",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in
        }
        alert.addAction(ok)

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension PostViewController : UIPickerViewDataSource {
    
    func setupDataSource() {
        self.subPickerView.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.source.count
    }
    
}

extension PostViewController : UIPickerViewDelegate {
    
    func setupDelegate() {
        self.subPickerView.delegate = self
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return source[row].displayName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedSub = row
    }
    
}







