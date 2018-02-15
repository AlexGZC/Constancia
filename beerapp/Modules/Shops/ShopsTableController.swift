//
//  ShopsTableController.swift
//  beerapp
//
//  Created by elaniin on 2/2/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit

class ShopsTableController: UITableViewController, UISearchBarDelegate{
    
    // MARK: - Let/Var
    var searching:Bool! = false
    var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Outlets
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
     // MARK: - Lifecycle
    override func viewDidLoad() {
        self.setUp()
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopsCell", for: indexPath)
        
        
        
        return cell
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.searchController.isActive = true
        self.searchController.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    
    
    // MARK: - Helpers/Initializers/Setups
    
    func setUp(){
        //SearchBar
        searchController.searchResultsUpdater = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = .red
        searchController.searchBar.placeholder = "Buscar bar o restaurante"
        
        
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.becomeFirstResponder()
        Core.itembarbackground(controller: self, barTint: Core.hexStringToUIColor(hex: "#213363"), titleColor: Core.hexStringToUIColor(hex: "#59BCCA"))
    }

}


extension ShopsTableController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}
