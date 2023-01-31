//
//  PlaceLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public protocol PlaceLoader {
    typealias Result = ([Region], [Place])
    
    func load(completion: @escaping (Result) -> Void)
}
