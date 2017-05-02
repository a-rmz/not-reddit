//
//  SearchViewController.swift
//  not-reddit-src
//
//  Created by Alejandro Ramírez on 5/1/17.
//  Copyright © 2017 Alejandro Ramírez. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var resultsTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
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

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        print(searchString)
        
        
        resultsTableView.reloadData()
    }
    
    
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search the reddit!"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Place the search bar view to the tableview headerview.
        resultsTableView.tableHeaderView = searchController.searchBar
    }
}
