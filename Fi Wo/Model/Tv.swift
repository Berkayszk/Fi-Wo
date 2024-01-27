//
//  Tv.swift
//  Fi Wo
//
//  Created by Berkay Sazak on 27.01.2024.
//

import Foundation

struct TrendingTvResponse: Codable {
    let results: [Tv]
}

struct Tv: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let relase_date: String?
    let vote_average: Double
  
}
