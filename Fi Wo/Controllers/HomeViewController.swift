//
//  HomeViewController.swift
//  Fi Wo
//
//  Created by Berkay Sazak on 19.11.2023.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeFeedTables : UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

  

}
