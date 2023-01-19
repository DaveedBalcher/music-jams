//
//  PlaceLoader.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/4/22.
//

import Foundation

public protocol PlaceLoader {
    typealias LoadCompletion = (_ regions: [Region], _ places: [Place]) -> Void

    func load(completion: @escaping LoadCompletion)
}
