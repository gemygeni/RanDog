//
//  DogAPI.swift
//  RanDog
//
//  Created by AHMED GAMAL  on 2/11/20.
//  Copyright © 2020 AHMED GAMAL . All rights reserved.
//

import Foundation
class DogAPI{
enum EndPoint  {
    case randomImageFromAll
    case ImageForBreed (String)
    case AllBreedList
    
    
    var url : URL{
        return   URL(string: self.stringValue)!
     }
    
    var stringValue : String {
        switch self {
        case .randomImageFromAll:
            return "https://dog.ceo/api/breeds/image/random"
        case .ImageForBreed (let breed) :
            return "https://dog.ceo/api/breed/\(breed)/images/random"
        case .AllBreedList : return "https://dog.ceo/api/breeds/list/all"
        }
     }
   }
}
