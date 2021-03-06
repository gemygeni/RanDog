//
//  ViewController.swift
//  RanDog
//
//  Created by AHMED GAMAL  on 2/11/20.
//  Copyright © 2020 AHMED GAMAL . All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var breeds : [String] = []
    
       override func viewDidLoad() {
           super.viewDidLoad()
           pickerView.delegate = self
           pickerView.dataSource = self
           
           getBreedList()
           
       }
    override func viewDidAppear(_ animated: Bool) {
        playVideo()
    }
    func  playVideo(){
           let url = Bundle.main.url(forResource: "randog", withExtension: "mp4")
           print("hhhhhhhhhhhhhhhh  \(url?.absoluteString)")
          let  player = AVPlayer(url: url!)
           let vc = AVPlayerViewController()
           vc.player = player
           present(vc, animated: true) {
               vc.player?.play()
           }
        
       }
    //func to get breed list
    func getBreedList(){
        let allBreedUrl = DogAPI.EndPoint.AllBreedList.url
        let task = URLSession.shared.dataTask(with: allBreedUrl) { (data, response, error) in
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
    
    
    
    @IBAction func fetchForBreed(_ sender: Any? = nil) {
        
        let randomIMageEndPoint = DogAPI.EndPoint.ImageForBreed(breeds[pickerView.selectedRow(inComponent: 0)]).url
        
        let task = URLSession.shared.dataTask(with: randomIMageEndPoint) { (data, response, error) in
            guard let data = data else{
                return
            }
            let imageData = try! JSONDecoder().decode(DogImage.self, from: data)
            
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
    
   
    
    @IBOutlet weak var imageView: UIImageView!
    
}

