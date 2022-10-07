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
        
        var weekDays: [String] {
            let weekdays = DateFormatter().weekdaySymbols
            let calendar = Calendar.current
            let index = calendar.component(.weekday, from: Date())
            return weekdays?.shift(withDistance: index) ?? []
        }
        
        private func map(_ venues: [DefaultVenue], _ neighborhoods: [DefaultNeighborhood]) -> [VenueItem] {
            venues.map { venue in
                
                let coordinatesItem = Coordinates(latitude: venue.coordinates[1], longitude: venue.coordinates[0])
                let neighborhoodItem = neighborhoods.first { $0.name == venue.neighborhood }?.item
                
                let item = VenueItem(id: UUID(),
                                     name: venue.name,
                                     imageURL: venue.image,
                                     coordinates: coordinatesItem,
                                     neighborhood: neighborhoodItem,
                                     events: venue.events?.map {
                    EventItem(id: UUID(),
                              name: $0.name,
                              type: $0.type ?? "",
                              dayOfTheWeek: $0.dayOfTheWeek ?? "",
                              dayOfTheWeekIndex:
                                Int(weekDays.firstIndex(of: $0.dayOfTheWeek ?? "")  ?? weekDays.count),
                              startTime: $0.startTime ?? "",
                              endTime: $0.endTime ?? "",
                              vibeIndex: $0.vibeIndex,
                              genres: $0.genres,
                              hosts: $0.hosts,
                              url: $0.url)
                    
                }  ?? [] )
                
                return item
            }
        }
    }
    
    private struct DefaultVenue: Decodable {
        let name: String
        let neighborhood: String
        let coordinates: [Double]
        let events: [DefaultEvent]?
        let description: String?
        let image: URL?
    }
    
    private struct DefaultEvent: Decodable {
        public let name: String
        public let dayOfTheWeek: String?
        public let startTime: String?
        public let endTime: String?
        public let vibeIndex: Int?
        public let genres: [String]?
        public let type: String?
        public let hosts: [String]?
        public let url: String
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
    
    internal static func map(_ data: Data) -> [VenueItem]  {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let loaded = try decoder.decode(Root.self, from: data)
            return loaded.venueItems
            
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
        
        return []
    }
}

private extension Array {

    /**
     Returns a new array with the first elements up to specified distance being shifted to the end of the collection. If the distance is negative, returns a new array with the last elements up to the specified absolute distance being shifted to the beginning of the collection.

     If the absolute distance exceeds the number of elements in the array, the elements are not shifted.
     */
    func shift(withDistance distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0 ?
            self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
            self.index(endIndex, offsetBy: distance, limitedBy: startIndex)

        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }

    /**
     Shifts the first elements up to specified distance to the end of the array. If the distance is negative, shifts the last elements up to the specified absolute distance to the beginning of the array.

     If the absolute distance exceeds the number of elements in the array, the elements are not shifted.
     */
    mutating func shiftInPlace(withDistance distance: Int = 1) {
        self = shift(withDistance: distance)
    }

}
