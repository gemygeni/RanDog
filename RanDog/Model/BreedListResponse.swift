//
//  BreedListResponse.swift
//  RanDog
//
//  Created by AHMED GAMAL  on 2/13/20.
//  Copyright © 2020 AHMED GAMAL . All rights reserved.
//

import Foundation
struct BreedListResponse : Codable {
    let message : [String : [String]]
    let status  : String
}
