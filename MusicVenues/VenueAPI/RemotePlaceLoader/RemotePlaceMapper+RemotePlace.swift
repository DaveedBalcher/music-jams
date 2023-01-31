//
//  RemotePlaceMapper.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/5/22.
//

import Foundation

extension RemotePlaceMapper {
    
    struct RemotePlace: Decodable {
        let name: String
        let levelOneRegion: String
        let coordinates: [Double]
        let events: [RemoteEvent]?
        
        var eventItems: [Event] {
            let items = events?.map { $0.item } ?? []
            return items.sorted()
        }
        
        func getItem(_ mapLevelOneRegion: (String)->(Region)) -> Place {
            Place(title: name,
                  latitude: coordinates[1],
                  longitude: coordinates[0],
                  levelOneRegion: mapLevelOneRegion(levelOneRegion),
                  events: eventItems)
        }
    }
}
