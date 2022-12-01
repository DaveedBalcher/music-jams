//
//  PlaceLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public protocol PlaceLoader {
    typealias LoadCompletion = ([LocalPlaceItem]) -> Void
    
    func load(completion: @escaping LoadCompletion)
}
