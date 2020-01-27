//
//  ViewController.swift
//  CoreData_Countries
//
//  Created by Sudhakar on 23/01/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit
import CoreData

class CountryViewController: UIViewController {

    @IBOutlet weak var table:UITableView!
    let viewModel = CountryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchCountries()
        self.table.dataSource = viewModel
        self.table.delegate = viewModel
    }
    
    @IBAction func actionForAddCountry(_ sender: UIBarButtonItem) {
        viewModel.addcountry(vc: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LanguageVC") {
            let vc = segue.destination as! LanguageViewController
            let coutnry = sender as! NSManagedObject
            vc.viewModel = LanguageViewModel(country: coutnry)
            //vc.verificationId = "Your Data"
        }
    }
}
extension CountryViewController:CountryViewModelDelegate{
    func selectedCounteryAtindex(object: NSManagedObject) {
        performSegue(withIdentifier: "LanguageVC", sender: object)
    }
    
    func saveCountrySuccessfully() {
        self.table.reloadData()
    }
}

