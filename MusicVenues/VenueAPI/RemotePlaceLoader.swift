//
//  RemotePlaceLoader.swift
//  MusicVenues
//
//  Created by Daveed Balcher on 1/26/23.
//

import Foundation
import Firebase

public final class RemotePlaceLoader: PlaceLoader {
    private var db: Firestore
    private var regions = [Region]()
    private var places = [Place]()
    
    public init() {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }
    
    private func loadCollection(of name: String, completion: @escaping ([[String:Any]]) -> Void) {
        db.collection(name).getDocuments() { (querySnapshot, error) in
            
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                let dataCollection = querySnapshot!.documents.map { $0.data() as [String:Any] }
                completion(dataCollection)
            }
        }
    }
    
    public func load(completion: @escaping (PlaceLoader.Result) -> Void) {
        loadCollection(of: "LevelOneRegions") { [weak self] dataCollection in
            guard let self = self else { return }
            
            for data in dataCollection {
                if let title = data["name"] as? String,
                   let colorString = data["color"] as? String,
                   let latitude = (data["coordinates"] as? [Double])?[0],
                   let longitude = (data["coordinates"] as? [Double])?[1] {
                    let region = Region(title: title, colorString: colorString, level: .one, latitude: latitude, longitude: longitude)
                    
                    self.regions.append(region)
                }
            }
        
            completion((self.regions, self.places))
        }
    }
}
