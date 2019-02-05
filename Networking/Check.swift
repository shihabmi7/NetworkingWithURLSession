//
//  Check.swift
//  Networking
//
//  Created by shihab on 31/1/19.
//  Copyright © 2019 shihab. All rights reserved.
//

import Foundation

let decoder = JSONDecoder()

struct Post: Codable {
    let id : Int
    let author: String
    let title:String
}


//let urlString = ""
//let url = URL(string: urlString)

let sharedSession = URLSession.shared
