//
//  SearchModel.swift
//  TvOSSample
//
//  Created by Luis Enrique Diaz Ramirez on 06/06/23.
//

import Foundation

struct Characters: Codable{
    let results: [Character]
}

struct Character: Codable{
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
}
