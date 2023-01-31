//
//  RemotePlaceLoader.swift
//  MusicVenues
//
//  Created by Daveed Balcher on 1/26/23.
//

import Foundation
import Firebase

public final class RemotePlaceLoader: PlaceLoader {
    private let db: Firestore

    public init() {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }

    public func load(completion: @escaping (PlaceLoader.Result) -> Void) {
        loadRegions { [weak self] regions in
            guard let self = self else { return }
            self.loadPlaces(regions: regions) { places in
                completion((regions, places))
            }
        }
    }
    
    private func loadRegions(completion: @escaping ([Region]) -> Void) {
        loadCollection(of: "LevelOneRegions") { documentObjects in
            var regions = [Region]()

            for object in documentObjects {
                if let region = RemotePlaceMapper.mapRegion(object) {
                    regions.append(region.item)
                }
            }
            completion(regions)
        }
    }

    private func loadPlaces(regions: [Region], completion: @escaping ([Place]) -> Void) {
        loadCollection(of: "Places") { documentObjects in
            var places = [Place]()

            for object in documentObjects {
                if let place = RemotePlaceMapper.mapPlace(object) {
                    places.append(place.getItem { string in regions.first { $0.title == string }! })
                }
            }

            completion(places)
        }
    }
    
    private func loadCollection(of name: String, completion: @escaping ([[String:Any]]) -> Void) {
        db.collection(name).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }

            guard let documents = querySnapshot?.documents else { return }

            let documentObjects = documents.map { $0.data() as [String:Any] }
            completion(documentObjects)
        }
    }
}
