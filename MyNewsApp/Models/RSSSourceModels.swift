//
//  RSSSourceModels.swift
//  MyNewsApp
//
//  Created by Алексей Матвеев on 28.01.2022.
//

import Foundation

class RssSources {
    
    let defaults = UserDefaults.standard
    
    static let shared = RssSources()
    
    struct UserSource: Codable {
        var sourceName: String
        var urlRss: String
    }
    
    var sources: [UserSource] {
        get {
            if let data = try? defaults.value(forKey: "sources") as? Data {
                return try! PropertyListDecoder().decode([UserSource].self, from: data)
            } else {
                return [UserSource]()
        }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "sources")
            }
        }
    }
    
    func saveSource(sourceName: String, urlRss: String) {
        let source = UserSource(sourceName: sourceName, urlRss: urlRss)
        sources.insert(source, at: 0)
    }
    
    func deleteSource(indexPath: Int) -> Void {
        sources.remove(at: indexPath)
        //defaults.synchronize()
    }
    
    func editSource(indexPath: Int, sN: String, uR: String) -> Void {
        sources.remove(at: indexPath)
        let tmp = UserSource(sourceName: sN, urlRss: uR)
        sources.insert(tmp, at: indexPath)
        //defaults.synchronize()
    }
    
    func getAllSources() -> [UserSource] {
        return sources
    }
    
}
