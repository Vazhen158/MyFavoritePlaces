//
//  barbershopModel.swift
//  MyPlaceOne
//
//  Created by Андрей Важенов on 26.05.2021.
//

import RealmSwift

class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic   var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?

    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
//       let barbershopNames = [
//           "Бошки Studio", "Bravada", "Big Bro",
//           "Crop Stop", "Провинция",
//           "1875", "Лось и ножницы",
//           "Sharp", "Borodach", "Brutal Guys"]
//
//    func savePlace() {
//
//
//        for barbershop in barbershopNames {
//            let image = UIImage(named: barbershop)
//            guard let imageData = image?.pngData() else {return}
//
//            let newPlace = Place()
//            newPlace.name = barbershop
//            newPlace.location = "Barnaul"
//            newPlace.type = "Barbershop"
//            newPlace.imageData = imageData
//
//            StorageManager.saveObject(newPlace)
//        }
//
//
//    }
}
