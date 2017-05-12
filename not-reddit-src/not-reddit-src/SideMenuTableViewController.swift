//
//  SideMenuTableViewController.swift
//  not-reddit-src
//
//  Created by curso on 23/03/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit
import reddift
import Foundation

class SideMenuTableViewController: UITableViewController {
    
    var source: [reddift.Subreddit] = []
    let session: Session = NotSession.sharedSession.session!
    let paginator: Paginator = Paginator()
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var cell2: UITableViewCell!
    @IBOutlet weak var cell3: UITableViewCell!
    @IBOutlet weak var cell4: UITableViewCell!
    @IBOutlet weak var cell5: UITableViewCell!
    @IBOutlet weak var cell6: UITableViewCell!
    @IBOutlet weak var cell7: UITableViewCell!
    @IBOutlet weak var cell8: UITableViewCell!
    @IBOutlet weak var cell9: UITableViewCell!
    @IBOutlet weak var cell10: UITableViewCell!
    @IBOutlet weak var cell11: UITableViewCell!
    @IBOutlet weak var cell12: UITableViewCell!
    @IBOutlet weak var cell13: UITableViewCell!
    @IBOutlet weak var cell14: UITableViewCell!
    @IBOutlet weak var cell15: UITableViewCell!
    @IBOutlet weak var cell16: UITableViewCell!
    @IBOutlet weak var cell17: UITableViewCell!
    @IBOutlet weak var cell18: UITableViewCell!
    @IBOutlet weak var cell19: UITableViewCell!
    @IBOutlet weak var cell20: UITableViewCell!
    

    override func viewDidLoad() {
        self.table.dataSource = self
        self.table.delegate = self
        setDataSource()
        
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*self.table.beginUpdates()
        for index in 0...19 {
            let ind = NSIndexPath(item: index, section: 0)
            self.table.reloadRows(at: [ind as IndexPath], with: .automatic)
        }
        self.table.endUpdates()*/
        self.table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    func setDataSource() {
        //let sub : Subreddit = Subreddit(subreddit: "birdsforscale")
        
            if NotSession.sharedSession.currentUser != nil {
                do {
                    print("my subreddits")
                
                try session.getUserRelatedSubreddit(.subscriber, paginator: paginator, completion: { (result: Result<Listing>) in
                    switch result {
                    case .success(let value):
                        let children: [reddift.Subreddit] = value.children as! [reddift.Subreddit]
                        self.source = children
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                        print(self.source[0].title)
                        
                        
                        
                        
                        
                    case .failure(let error):
                        print(error)
                    }
                })
                }catch { print(error)}
                
                
                
            }else {
            
                do {
            
            try session.getSubreddit(SubredditsWhere.default, paginator: paginator, completion: { (result: Result<Listing>) in
                
                switch result {
                case .success(let value):
                    let children: [reddift.Subreddit] = value.children as! [reddift.Subreddit]
                    self.source = children
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    print(self.source[0].title)
                    
                    
                    
                    
                    
                case .failure(let error):
                    print(error)
                }
                //print(result)
                
            })
        }catch { print(error)}
        
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        switch segue.identifier! {
        case "cell1":
            if cell1.textLabel?.text != nil {
                let st = cell1.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell2":
            if cell2.textLabel?.text != nil {
                let st = cell2.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell3":
            if cell3.textLabel?.text != nil {
                let st = cell3.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell4":
            if cell4.textLabel?.text != nil {
                let st = cell4.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell5":
            if cell5.textLabel?.text != nil {
                let st = cell5.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell6":
            if cell6.textLabel?.text != nil {
                let st = cell6.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell7":
            if cell7.textLabel?.text != nil {
                let st = cell7.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell8":
            if cell8.textLabel?.text != nil {
                let st = cell8.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell9":
            if cell9.textLabel?.text != nil {
                let st = cell9.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell10":
            if cell10.textLabel?.text != nil {
                let st = cell10.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell11":
            if cell11.textLabel?.text != nil {
                let st = cell11.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell12":
            if cell12.textLabel?.text != nil {
                let st = cell12.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell13":
            if cell13.textLabel?.text != nil {
                let st = cell13.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell14":
            if cell14.textLabel?.text != nil {
                let st = cell14.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell15":
            if cell15.textLabel?.text != nil {
                let st = cell15.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell16":
            if cell16.textLabel?.text != nil {
                let st = cell16.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell17":
            if cell17.textLabel?.text != nil {
                let st = cell17.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell18":
            if cell18.textLabel?.text != nil {
                let st = cell18.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell19":
            if cell19.textLabel?.text != nil {
                let st = cell19.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        case "cell20":
            if cell20.textLabel?.text != nil {
                let st = cell20.textLabel!.text!
                
                let start = st.index(st.startIndex, offsetBy: 3)
                let length = (st.characters.count) - 1
                let end = st.index(st.startIndex, offsetBy: length)
                print(st.substring(with: start..<end))
                appDelegate.subreddit = st.substring(with:start..<end)
            }
        default:
            print("no segue for cell")
        }
        
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.source.count > 0 {
            cell.textLabel?.text = self.source[indexPath.row].url
        }
        
    }
    
    
    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sidecell", for: indexPath)
        
        let link: reddift.Link = self.source[indexPath.row]
        
        //print(JSONStringify(value: link as AnyObject, prettyPrinted: true))
        print(link)
        print("")
        
        
        let url = URL.init(string: link.thumbnail)
        
        // Async management of the images
        /*DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.imageViewThumb.image = UIImage(data: data!)
            }
        }*/
        
        return cell
    }*/
    
    

}
