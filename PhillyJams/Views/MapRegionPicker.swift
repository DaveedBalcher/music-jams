//
//  MapRegionPicker.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/12/22.
//

import SwiftUI

struct MapRegionPicker: View {
    let mapRegions: [String]
    @Binding var selectedMapRegions: String
    
    var body: some View {
        Form {
            ForEach(mapRegions, id: \.self) { option in
                Button {
                    selectedMapRegions = option
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

struct MapRegionPicker_Previews: PreviewProvider {
    static var previews: some View {
        MapRegionPicker(mapRegions: ["A", "B", "C", "D"], selectedMapRegions: .constant("A"))
    }
}
