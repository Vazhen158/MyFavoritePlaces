//
//  MainViewController.swift
//  MyPlaceOne
//
//  Created by Андрей Важенов on 26.05.2021.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

   
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet var reversedSortingButton: UIBarButtonItem!
    
    var barbershop: Results<Place>! // Results это автообновляемый тип контейнера, который запрашивает объекты, позволяет работать с данными в реальном времени.
    var ascendingSorting = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        barbershop = realm.objects(Place.self)

        
       
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return barbershop.isEmpty ? 0 : barbershop.count
  }

   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let place = barbershop[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        return [deleteAction]
    }

    
    
    

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let place = barbershop[indexPath.row]
            let newPlaceVC = segue.destination as! NewPlaceViewController
            newPlaceVC.currrentPlace = place
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewPlaceViewController else {return}
        
        newPlaceVC.savePlace()
    
        tableView.reloadData() // метод обновляет интерфейс
        
    }
    
    
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
       sorting()
        
    }
    
    @IBAction func reversedSorting(_ sender: UIBarButtonItem) {
        
        ascendingSorting.toggle()
        if ascendingSorting {
            reversedSortingButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reversedSortingButton.image = #imageLiteral(resourceName: "ZA")
        }
        
        sorting()
        
    }
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            barbershop = barbershop.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            barbershop = barbershop.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        tableView.reloadData()
    }
}
