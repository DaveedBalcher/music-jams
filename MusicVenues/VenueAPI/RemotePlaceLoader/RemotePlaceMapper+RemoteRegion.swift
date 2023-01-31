//
//  RemotePlaceMapper.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/5/22.
//

import Foundation

extension RemotePlaceMapper {
    
    struct RemoteRegion: Decodable {
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
}
