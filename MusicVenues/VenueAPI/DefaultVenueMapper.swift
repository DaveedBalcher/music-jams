//
//  VenueItemMapper.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/5/22.
//

import Foundation

public final class DefaultVenueMapper {
    
    private struct Root: Decodable {
        let venues: [DefaultVenue]
        let neighborhoods: [DefaultNeighborhood]
        
        var venueItems: [VenueItem] {
            map(venues, neighborhoods)
        }
        
        var neightborhoodItems: [NeighborhoodItem] {
            neighborhoods.map { $0.item }
        }
        
        private func map(_ venues: [DefaultVenue], _ neighborhoods: [DefaultNeighborhood]) -> [VenueItem] {
            venues.map { venue in
                
                let coordinatesItem = Coordinates(latitude: venue.coordinates[1], longitude: venue.coordinates[0])
                let neighborhoodItem = neighborhoods.first { $0.name == venue.neighborhood }?.item
                let vibeType = VibeType.allCases[venue.vibeIndex ?? 2]
                
                let item = VenueItem(id: UUID(),
                                     name: venue.name,
                                     imageURL: venue.image,
                                     coordinates: coordinatesItem,
                                     neighborhood: neighborhoodItem,
                                     genres: venue.genreTypes,
                                     vibe: vibeType)
                
                return item
            }
        }
    }
    
    private struct DefaultVenue: Decodable {
        let name: String
        let neighborhood: String
        let coordinates: [Double]
        let vibeIndex: Int?
        let genres: [String]?
        let description: String?
        let image: URL?
        
        var genreTypes: [GenreType] {
            (genres?.compactMap { GenreType.init(name: $0) }) ?? []
        }
    }
    
    private struct DefaultNeighborhood: Decodable {
        var name: String
        var coordinates: [Double]
        var color: String
        
        var item: NeighborhoodItem {
            
            let coordinatesItem = Coordinates(latitude: coordinates[1], longitude: coordinates[0])
            return NeighborhoodItem(name: name,
                                    center: coordinatesItem,
                                    color: color)
        }
    }
    
    internal static func map(_ data: Data) -> (venues: [VenueItem], neighborhoods: [NeighborhoodItem])  {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let loaded = try decoder.decode(Root.self, from: data)
            return (venues: loaded.venueItems, neighborhoods: loaded.neightborhoodItems)
            
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
