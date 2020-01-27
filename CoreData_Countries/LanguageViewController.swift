//
//  LanguageViewController.swift
//  CoreData_Countries
//
//  Created by Sudhakar on 23/01/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController,LanguageViewModelDelegate {
   

    @IBOutlet weak var table:UITableView!
    var viewModel : LanguageViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.table.dataSource = viewModel
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionForAddLanguage(_ sender: UIBarButtonItem) {
           viewModel.addLanguage(vc: self)
    }
    
    func saveLanguageSuccessfully() {
        self.table.reloadData()
    }
       
}

