//
//  CountryViewModel.swift
//  CoreData_Countries
//
//  Created by Sudhakar on 23/01/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol CountryViewModelDelegate:class {
    func saveCountrySuccessfully()
    func selectedCounteryAtindex(object:NSManagedObject)
}

class CountryViewModel:NSObject{
    weak var delegate:CountryViewModelDelegate?
    private var countries = [NSManagedObject]()
    private var context:NSManagedObjectContext!
    override init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func addcountry(vc:UIViewController){
        let alert = UIAlertController(title: "Country", message: nil, preferredStyle: .alert)
        alert.addTextField() { newTextField in
              newTextField.placeholder = "Enter Name"
          }
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
          alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
              if
                  let textFields = alert.textFields,
                  let tf = textFields.first,
                  let result = tf.text
              {
                self.saveCountry(name: result)
              }
              else
              {
                
             }
          })
        vc.present(alert, animated: true, completion: nil)
    }
    func saveCountry(name:String){
        let entity = NSEntityDescription.entity(forEntityName: "Country", in: context)
        let newCountry = NSManagedObject(entity: entity!, insertInto: context)
        newCountry.setValue(name, forKey: "name")
        do{
           try context.save()
            countries.append(newCountry)
            self.delegate?.saveCountrySuccessfully()
        }catch{
            print("Storing data Failed")
        }
        
    }
    
    func fetchCountries(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        request.returnsObjectsAsFaults = false
        do{
            self.countries = try context.fetch(request) as![NSManagedObject]
        }catch{
             print("Failed fetchCountries")
        }
       
    }
   
}

extension CountryViewModel:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let country = self.countries[indexPath.row]
        cell.textLabel?.text = country.value(forKey: "name") as? String
        return cell
    }
    
}

extension CountryViewModel:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCounteryAtindex(object: countries[indexPath.row])
    }
}
