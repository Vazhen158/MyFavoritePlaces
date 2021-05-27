//
//  NewPlaceViewController.swift
//  MyPlaceOne
//
//  Created by Андрей Важенов on 26.05.2021.
//

import UIKit

class NewPlaceViewController: UITableViewController {
    
    var currrentPlace: Place?
    var imageIsChanged = false
    

    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBOutlet var placeName: UITextField!
    
    @IBOutlet var placeLocation: UITextField!
    
    @IBOutlet var placeType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.async {     // вщзможность делать запись в фоновом потоке
//            self.newPlace.savePlace()
            
 //       }
        
//        newPlace.savePlace()

        tableView.tableFooterView = UIView() // убирает разлиновку на экране, где нет строк с контентом
        saveButton.isEnabled = false // при переходе на экран добавления по умолчанию кнопка будет отключена
        setupEditScreen()
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
       
        
    }

   //MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet) // добавляем всплывающее окно с предложением выбрать картинку из галереии или сделать фото
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true) // скрытие клавиатуры по тапу на экран
        }
    }
    func savePlace() {
        
       
        var image: UIImage?
        if imageIsChanged {
            image = placeImage.image
            
        } else {
        image = #imageLiteral(resourceName: "scissors")
        }
        
        let imageData = image?.pngData()
        
        let  newPlace = Place(name: placeName.text!, location: placeLocation.text, type: placeType.text, imageData: imageData)
        if currrentPlace != nil {
            try! realm.write {
                currrentPlace?.name = newPlace.name
                currrentPlace?.location = newPlace.location
                currrentPlace?.type = newPlace.type
                currrentPlace?.imageData = newPlace.imageData
                
            }
                
                
        } else {
            StorageManager.saveObject(newPlace)
        }
        
        
        
    }
    private func setupEditScreen() {   //метод для редактирования существующей записи
        if currrentPlace != nil {
            setupNavigationBar()
            imageIsChanged = true
            guard let data = currrentPlace?.imageData, let image = UIImage(data: data) else {return}
            
            placeImage.image = image
            
            placeImage.contentMode = .scaleAspectFill //данное свойство меняет размер изображения в окне редактирования
            placeName.text = currrentPlace?.name
            placeLocation.text = currrentPlace?.location
            placeType.text = currrentPlace?.type
            
        }
        
    }
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currrentPlace?.name
        saveButton.isEnabled = true
        
    }

    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}
// MARK: Text field delegate

extension NewPlaceViewController: UITextFieldDelegate {
    // скрываем клавиатуру по нажатию на  Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() { // метод для textFieldChanged, который в реальном времени отслеживает заполненно ли текстовое поле
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
  
    
   
}
//MARK: Work with image
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
    
    if UIImagePickerController.isSourceTypeAvailable(source) {
    let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    imagePicker.allowsEditing = true // даем пользователю возможность редактирования изображения
        imagePicker.sourceType = source
        present(imagePicker, animated: true)
    }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage // метод дает возможность использования отредактированного польpователем изображения
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        imageIsChanged = true
        
        
        dismiss(animated: true)
    }
}
