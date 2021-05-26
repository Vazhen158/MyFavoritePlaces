//
//  MainViewController.swift
//  MyPlaceOne
//
//  Created by Андрей Важенов on 26.05.2021.
//

import UIKit

class MainViewController: UITableViewController {
    

    
   // var barbershop = Place.getBarbershop()
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    return barbershop.count
//    }

   
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
//
//        let place = barbershop[indexPath.row]
//
//        cell.nameLabel?.text = place.name
//        cell.locationLabel.text = place.location
//        cell.typeLabel.text = place.type
//
//        if place.image == nil {
//            cell.imageOfBarbershop?.image = UIImage(named: place.barbershopImage!)
//        } else {
//            cell.imageOfBarbershop.image = place.image
//        }
//
//
////        cell.imageOfBarbershop?.image = UIImage(named: barbershop[indexPath.row].barbershopImage!)
//        cell.imageOfBarbershop?.layer.cornerRadius = cell.imageOfBarbershop.frame.size.height / 2 //круглые иконки
//        cell.imageOfBarbershop?.clipsToBounds = true
//        return cell
//    }
//    // MARK: - Table view delegate
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 85
//    }
   

    

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
       // barbershop.append(newPlaceVC.newPlace!)
        tableView.reloadData() // метод обновляет интерфейс
        
    }
}
