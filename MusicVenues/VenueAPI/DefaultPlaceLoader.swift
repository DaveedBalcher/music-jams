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
    private var regions = [Region]()
    
    func getPlaces() -> [Place] {
        if places.isEmpty {
            loadDefaultItems()
        }
        return places
    }
    
    func getRegions() -> [Region] {
        if regions.isEmpty {
            loadDefaultItems()
        }
        return regions
    }
    
    private func loadDefaultItems() {
        if let path = Bundle.main.path(forResource: fileLocation, ofType: nil) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                (self.regions, self.places) =  DefaultPlaceMapper.map(data)
            } catch {
                print("Failed to decode \(fileLocation) from bundle. Error: ", error)
            }
        }
    }
    
    public func load(with filters: [Property], completion: @escaping LoadCompletion) {

    }
//
//    private func filter(with filters: [String: String?]) -> [Place] {
//        if filters.isEmpty { return places }
//
//        return places.filter { placeItem in
//
//            for filter in filters {
//
//                let type = filter.key
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
//    }
}
