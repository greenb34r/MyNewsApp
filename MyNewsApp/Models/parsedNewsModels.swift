//
//  parsedNewsModels.swift
//  MyNewsApp
//
//  Created by Алексей Матвеев on 24.01.2022.
//

import Foundation


class NewsApiResponse: Codable{
    let status: String?
    let totalResults: Int?
    let articles: [NewsListItem]?
    
}

class NewsListItem: Identifiable, Codable {
   // var id: ObjectIdentifier
    
    var title: String?
    var description: String?
//    var url: String?
//    var urlToImage: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
    }
    
}


func parseFromData(data: Data) -> (totalResults: Int, articles: [NewsListItem]) {
    var response: NewsApiResponse
    do {
        response = try JSONDecoder().decode(NewsApiResponse.self, from: data)
    } catch {
        print("ERROR PARSING THE JSON: \(error)")
        return (totalResults: 0, articles: [])
    }
    
    if response.status != "ok" {
        print("Status is not ok: \(response.status ?? "Error")")
        return (totalResults: 0, articles: [])
    }
    return (totalResults: response.totalResults, articles: response.articles) as! (totalResults: Int, articles: [NewsListItem])
}
