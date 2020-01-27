//
//  LanguageViewModel.swift
//  CoreData_Countries
//
//  Created by Sudhakar on 24/01/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol LanguageViewModelDelegate:class {
    func saveLanguageSuccessfully()
  
}

class LanguageViewModel:NSObject{
    weak var delegate:LanguageViewModelDelegate?
    private var country : NSManagedObject
    private var langauages = [NSManagedObject]()
    private var context:NSManagedObjectContext!

    init(country:NSManagedObject) {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         context = appDelegate.persistentContainer.viewContext
        self.country = country
        langauages = self.country.value(forKey: "languages") as! [NSManagedObject]
    }
    
    func addLanguage(vc:UIViewController){
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
                self.saveLanguage(name: result)
              }
              else
              {

             }
          })
        vc.present(alert, animated: true, completion: nil)
    }
    func saveLanguage(name:String){
        let entity = NSEntityDescription.entity(forEntityName: "Language", in: context)
        let newLanguage = NSManagedObject(entity: entity!, insertInto: context)
        newLanguage.setValue(name, forKey: "name")
        newLanguage.setValue(country, forKey: "country")
        do{
             try context.save()
             langauages.append(newLanguage)
             self.delegate?.saveLanguageSuccessfully()
        }catch{
            print("Storing data Failed")
        }

    }
//
//    func fetchCountries(){
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
//        request.returnsObjectsAsFaults = false
//        do{
//            self.countries = try context.fetch(request) as![NSManagedObject]
//        }catch{
//             print("Failed fetchCountries")
//        }
//
//    }
   
}

extension LanguageViewModel:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        langauages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let language = self.langauages[indexPath.row]
        cell.textLabel?.text = language.value(forKey: "name") as? String
        return cell
    }
    
}

