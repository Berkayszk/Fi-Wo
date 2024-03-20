//
//  Movie.swift
//  Fi Wo
//
//  Created by Berkay Sazak on 23.01.2024.
//

import Foundation

struct TrendingTitleResponse : Codable {
    let results : [Title]
}

struct Title : Codable{
    let id: Int
    let media_type: String?
    let original_title: String?
    let original_name: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let relase_date: String?
    let vote_average: Double
}
