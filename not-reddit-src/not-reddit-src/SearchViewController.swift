//
//  SearchViewController.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 5/1/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import reddift
import UIKit

class SearchViewController: UIViewController {
    
    let session = NotSession.sharedSession.session
    var source: [Subreddit] = []
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var resultsTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureDataSource()
        configureDelegate()
        source = []
        resultsTableView.reloadData()
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

extension SearchViewController: UITableViewDataSource {
    
    func configureDataSource() {
        resultsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        
        cell.textLabel!.text = self.source[indexPath.row].displayName
        cell.detailTextLabel!.text = String(self.source[indexPath.row].subscribers) + " subscribed"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.source[indexPath.row].displayName)
        appDelegate.subreddit = self.source[indexPath.row].displayName
        tabBarController!.selectedIndex = 1
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func configureDelegate() {
        resultsTableView.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        
        try? session?.getSubredditSearch(searchString, paginator: Paginator()) { (result: Result<Listing>) in
            switch result {
            case .success(let searchResult):
                let subs: [Subreddit] = searchResult.children as! [Subreddit]
                self.source = subs
                for sub in subs { print(sub.displayName) }
                self.source.sort { ($0.subscribers > $1.subscribers) }
                
            case .failure(let err) :
                print(err.localizedDescription)
            }
            DispatchQueue.main.async {
                self.resultsTableView.reloadData()
            }
        }
        
    }
    
    
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search the reddit!"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.enablesReturnKeyAutomatically = true
        searchController.searchBar.returnKeyType = .search
        
        // Place the search bar view to the tableview headerview.
        resultsTableView.tableHeaderView = searchController.searchBar
    }
}
