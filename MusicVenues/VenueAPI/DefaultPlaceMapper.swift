//
//  DefaultPlaceMapper.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/5/22.
//

import Foundation

final class DefaultPlaceMapper {
    
    struct Root: Decodable {
        let levelOneRegions: [DefaultRegion]
        let places: [DefaultPlace]
        
        var regionItems: [Region] {
            levelOneRegions.map { $0.item }
        }
        
        var placeItems: [Place] {
            places.map {
                $0.getItem { string in
                    regionItems.first { $0.title == string }!
                }
            }
        }
        
        struct DefaultRegion: Decodable {
            let name: String
            let coordinates: [Double]
            let color: String
            
            var item: Region {
                Region(title: name,
                       colorString: color,
                       level: .one,
                       latitude: coordinates[1],
                       longitude: coordinates[0])
            }
        }
        
        struct DefaultPlace: Decodable {
            let name: String
            let levelOneRegion: String
            let coordinates: [Double]
            
            func getItem(_ mapLevelOneRegion: (String)->(Region)) -> Place {
                Place(title: name,
                      latitude: coordinates[1],
                      longitude: coordinates[0],
                      regionLevelOne: mapLevelOneRegion(levelOneRegion),
                      properties: [])
            }
        }
    }
    
    static func map(_ data: Data) -> (regions: [Region], places: [Place])  {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let loaded = try decoder.decode(Root.self, from: data)
            return (regions: loaded.regionItems, places: loaded.placeItems)
            
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            
        }
        
        return (regions: [], places: [])
    }
}
