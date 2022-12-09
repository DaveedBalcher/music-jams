//
//  LocalPlaceLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public final class DefaultPlaceLoader: PlaceLoader {

    public init() {}
    
    private var fileLocation: String {
        "DefaultPlaceStore.json"
    }
    
    private var places = [Place]()
    
    private func getPlaces() -> [Place] {
        if places.isEmpty {
            loadDefaultItems()
        }
        return places
    }
    
//    private var regions = [Region]()
//
//    private func getRegions() -> [Region] {
//        if regions.isEmpty {
//            loadDefaultItems()
//        }
//        return regions
//    }
    
    private func loadDefaultItems() {
        if let path = Bundle.main.path(forResource: fileLocation, ofType: nil) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.places =  DefaultPlaceMapper.map(data)
            } catch {
                print("Failed to decode \(fileLocation) from bundle. Error: ", error)
            }
        }
    }
    
    public func load(with filters: [Property], completion: @escaping LoadCompletion) {
        let places = getPlaces()
//        let regions =  getRegions()
        if filters.isEmpty {
            completion(places)
        } else {
            completion(filter(places, with: filters))
        }
    }

    private func filter(_ placeItems: [Place], with filters: [Property]) -> [Place] {
        return placeItems.filter { placeItem in
            
            for prop in filters {
                if placeItem.properties.contains(where: { $0 == prop }) {
                    // Should include
                } else {
                    return false
                }
            }
            return true
        }
//
//
//        filter { placeItem in
//
//            for prop in filters {
//
//                let type = prop.title
//
//                if let filterParam = placeItem.filterValues.filter({ $0.key == type }).first,
//                   (filter.value == nil || filterParam.value.contains(filter.value!)) {
//                    // Should include place
//                } else {
//                    return false
//                }
//            }
//            return true
//        }
    }
}
