//
//  RemotePlaceMapper.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/5/22.
//

import Foundation
import Firebase

final class RemotePlaceMapper {
    
    private static func decode<T>(_ type: T.Type, fromJSONObject object: [String:Any]) -> T? where T: Decodable {
        let decoder = JSONDecoder()
        
        do {
            let loaded = try decoder.decode(T.self, from: try JSONSerialization.data(withJSONObject: object, options: []))
            return loaded
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static func mapPlace(_ jsonObject: [String:Any]) -> RemotePlace? {
        return decode(RemotePlace.self, fromJSONObject: jsonObject)
    }
    
    static func mapRegion(_ jsonObject: [String:Any]) -> RemoteRegion? {
        return decode(RemoteRegion.self, fromJSONObject: jsonObject)
    }
}
