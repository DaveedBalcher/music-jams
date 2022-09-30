//
//  LocalVenueLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public final class DefaultVenueLoader: VenueLoader {

    public init() {}
    
    private var fileLocation: String {
        "DefaultVenueStore.json"
    }
    
    var venues: [VenueItem] {
        if let path = Bundle.main.path(forResource: fileLocation, ofType: nil) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return DefaultVenueMapper.map(data)
            } catch {
                print("Failed to decode \(fileLocation) from bundle. Error: ", error)
            }
        }
        return []
    }
    
    public func load(completion: @escaping LoadCompletion) {
        completion(venues)
    }
}
