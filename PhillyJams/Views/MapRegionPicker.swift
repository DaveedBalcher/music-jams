//
//  MapRegionPicker.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/12/22.
//

import SwiftUI

struct MapRegionPicker: View {
    let title: String
    let mapRegions: [String]
    let selectedMapRegions: String
    
    let didComplete: (String?)->Void
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Spacer()
                Text(title)
                    .font(.headline)
                Spacer()
                Button {
                    didComplete(nil)
                } label: {
                    Text("Cancel")
                }
                .padding([.trailing], 24)
            }
            .padding([.top], 24)
            
            Form {
                ForEach(mapRegions, id: \.self) { option in
                    Button {
                        didComplete(option)
                    } label: {
                        HStack {
                            ZStack {
                                if option == selectedMapRegions {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .frame(width: 20)
                            Text(option)
                        }
                    }
                }
            }
        }
    }
}

struct MapRegionPicker_Previews: PreviewProvider {
    static var previews: some View {
        MapRegionPicker(title: "Letters",
                        mapRegions: ["A", "B", "C", "D"],
                        selectedMapRegions: "A") { _ in }
    }
}
