//
//  MainViewController.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 3/12/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift

class MainViewController: UIViewController,UITableViewDelegate {
    
    let session = NotSession.sharedSession.session
    
    @IBOutlet weak var tableViewPost: PostTableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Refresh the data
        tableViewPost.setDataSource()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func askLogin(){
        let alert = UIAlertController(title: "Inicia sesiòn para acceder a esta funciòn", message: "Para poder acceder a las funcione de votar o guardar inica sesiòn en la pestaña de usuario", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
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


