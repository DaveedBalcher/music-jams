//
//  MapLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public protocol VenueLoader {
    typealias LoadCompletion = ([VenueItem]) -> Void
    
    func load(completion: @escaping LoadCompletion)
}
