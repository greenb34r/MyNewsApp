//
//  AllSourceXMLModel.swift
//  MyNewsApp
//
//  Created by Алексей Матвеев on 02.02.2022.
//

import Foundation



struct ListItemsForRss {
    var identifire: Int
    var nameSource: String
    var urlSource: String
    var listItems: [RSSItem]
}

class ListItemsForRssHandler {
    static var shared = ListItemsForRssHandler()
    var listItemsForRss: ListItemsForRss?
    var listItemsRssArray: [ListItemsForRss] = []
    var allSources = RssSources.shared.getAllSources()

    var rssItemsFromSource: [RSSItem] = []

    func fetchData(_ url: String) -> [RSSItem] {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: url) {(rssItems) in
            self.rssItemsFromSource = rssItems
        }
        return rssItemsFromSource
    }

    func addToList() {
        var i = 0
        
        //rssItems = []
        listItemsRssArray = []
        
        print(allSources.count)
        while i < allSources.count {
            let t = fetchData(allSources[i].urlRss as String) //Я не знаю как и почему это работает
            print(t)
            listItemsForRss = ListItemsForRss(identifire: i, nameSource: allSources[i].sourceName, urlSource: allSources[i].urlRss, listItems: self.rssItemsFromSource)

            listItemsRssArray.append(listItemsForRss!)
            //print(listItemsRssArray)

            i += 1
        }
    }
    
    func getToList() -> [ListItemsForRss] {
        return listItemsRssArray
    }
    
}
