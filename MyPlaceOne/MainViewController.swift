//
//  MainViewController.swift
//  MyPlaceOne
//
//  Created by Андрей Важенов on 26.05.2021.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    

    
    var barbershop: Results<Place>! // Results это автообновляемый тип контейнера, который запрашивает объекты, позволяет работать с данными в реальном времени.
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        barbershop = realm.objects(Place.self)

        
       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return barbershop.isEmpty ? 0 : barbershop.count
  }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let place = barbershop[indexPath.row]

        cell.nameLabel?.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfBarbershop.image = UIImage(data: place.imageData!)

        cell.imageOfBarbershop?.layer.cornerRadius = cell.imageOfBarbershop.frame.size.height / 2 //круглые иконки
        cell.imageOfBarbershop?.clipsToBounds = true
       return cell
   }
    
    
   // MARK: - Table view delegate
// метод для вызова ячейки меню свайпом c право на лево
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let place = barbershop[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        return [deleteAction]
    }

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewPlaceViewController else {return}
        
        newPlaceVC.saveNewPlace()
    
        tableView.reloadData() // метод обновляет интерфейс
        
    }
}
