//
//  ViewController.swift
//  RanDog
//
//  Created by AHMED GAMAL  on 2/11/20.
//  Copyright © 2020 AHMED GAMAL . All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
   var breeds : [String] = []
    
    //func to get breed list
    func getBreedList(){
        let allBreedaUrl = DogAPI.EndPoint.AllBreedList.url
        let task = URLSession.shared.dataTask(with: allBreedaUrl) { (data, response, error) in
            guard let data = data else {return}
            let decoder = JSONDecoder()
            let breedListDictionary = try! decoder.decode(BreedListResponse.self, from: data)
             let breedList = breedListDictionary.message.keys.map({$0})
            self.breeds = breedList
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        }
        
        task.resume()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         
        let randomImageEndpoint = DogAPI.EndPoint.ImageForBreed(breeds[row]).url
               let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
                   guard let data = data
                       else{
                           return
                   }
                   let decoder = JSONDecoder()
                   let imageData = try! decoder.decode(DogImage.self, from: data)
               
                guard let imageUrl = URL(string: (imageData.message ))  else {return}
                   let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                       guard let data = data else {return}
                      let dogImage =  UIImage(data: data)
                       DispatchQueue.main.async {
                           self.imageView.image = dogImage
                       }
                   }
                   task.resume()
                   
               }
               task.resume()
    }
    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
       getBreedList()
        
    }

    @IBOutlet weak var imageView: UIImageView!
    
}

