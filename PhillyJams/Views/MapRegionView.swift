//
//  NeighborhoodView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/12/22.
//

import SwiftUI

struct MapRegionView: View {
    let mapRegionTitle: String
    let regionFiltersDescription: String
    
    let onTapSelectMapRegion: ()->()
    let onTapSelectRegionFilters: ()->()
    
    var body: some View {
        HStack {
            Image(systemName: "map")
                .resizable()
                .frame(width: 16, height: 14)
                .padding([.leading], 8)
            
            VStack(alignment: .leading) {
                Text(mapRegionTitle)
                    .font(.caption)
                    .fontWeight(.semibold)
                Text(regionFiltersDescription)
                    .font(.caption2)
                    .fontWeight(.light)
            }
            
            Spacer()
            
            Image(systemName: "line.3.horizontal.decrease")
                .resizable()
                .frame(width: 14, height: 9)
                .padding(7)
                .background(Circle().strokeBorder(.secondary))
                .onTapGesture {
                    
                }
            
        }
        .padding([.leading, .trailing], 4)
        .padding([.top, .bottom], 6)
        .background(Capsule().strokeBorder(.secondary))
        .frame(minWidth: 202)
        .offset(y: -4)
    }
}

struct MapRegionView_Previews: PreviewProvider {
    static var previews: some View {
        MapRegionView(mapRegionTitle: "Philadelphia", regionFiltersDescription: "Jams · Chill · Jazz") {
            
        } onTapSelectRegionFilters: {
            
        }
    }
}
