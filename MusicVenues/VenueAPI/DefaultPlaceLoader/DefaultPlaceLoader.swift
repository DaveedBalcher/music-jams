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
    
    private var regions = [Region]()
    private var places = [Place]()
    
    private func loadDefaultItems() {
        if let path = Bundle.main.path(forResource: fileLocation, ofType: nil) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                (regions, places) = DefaultPlaceMapper.map(data)
            } catch {
                print("Failed to decode \(fileLocation) from bundle. Error: ", error)
            }
        }
    }
    
    public func load(completion: @escaping (PlaceLoader.Result) -> Void) {
        loadDefaultItems()
        completion((regions,places))
    }
}
