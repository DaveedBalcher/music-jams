//
//  DefaultPlaceMapper.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/5/22.
//

import Foundation

final class DefaultPlaceMapper {
    
    typealias MappedResult = PlaceLoader.Result
    
    static func map(_ data: Data) -> MappedResult {
        let decoder = JSONDecoder()
        
        do {
            let loaded = try decoder.decode(Root.self, from: data)
            return (loaded.regionItems, loaded.placeItems)
            
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
        
        return ([],[])
    }
}
