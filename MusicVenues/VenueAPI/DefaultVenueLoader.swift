//
//  LocalVenueLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public final class DefaultVenueLoader: VenueLoader {
    
    private var loadedVenues = [VenueItem]()
    private var loadedNeighborhoods = [NeighborhoodItem]()
    
    public init() {}
    
    private var fileLocation: String {
        "DefaultVenueStore.json"
    }
    
    public func load() {
        if let path = Bundle.main.path(forResource: fileLocation, ofType: nil) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                (loadedVenues, loadedNeighborhoods) = DefaultVenueMapper.map(data)
                return
            } catch {
                // handle error
            }
        }
        
        fatalError("Failed to decode \(fileLocation) from bundle.")
    }
    
    public func retrieve() -> (venues: [VenueItem], neighborhoods: [NeighborhoodItem]) {
        return (loadedVenues, loadedNeighborhoods)
    }
}
