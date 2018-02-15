//
//  PromotionsTableController.swift
//  beerapp
//
//  Created by alex on 2/6/18.
//  Copyright © 2018 Elaniin. All rights reserved.
//

import UIKit
import SwiftyBeaver

class PromotionsTableController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - Let/Var
    
    // MARK: - Outlets
    @IBOutlet weak var promotionsSegmentedControl: UISegmentedControl!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Datasources
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionsCells", for: indexPath)

        return cell
    }
    
     // MARK: - Actions
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch promotionsSegmentedControl.selectedSegmentIndex {
        case 0:
            SwiftyBeaver.error("1")
        case 1:
            SwiftyBeaver.debug("2")
        default:
            break;
        }
    }
    
    
   
    
    
    // MARK: - Helpers/Initializers/Setups
    
    
}
