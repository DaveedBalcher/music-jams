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
        Button {
            onTapSelectMapRegion()
        } label: {
            HStack {
                Image(systemName: "map")
                    .resizable()
                    .frame(width: 20, height: 17)
                    .padding([.leading], 12)
                
                VStack(alignment: .leading) {
                    Text(mapRegionTitle)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text(regionFiltersDescription)
                        .font(.subheadline)
                        .fontWeight(.light)
                }
                
                Spacer()
                
                Button {
                    onTapSelectRegionFilters()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .resizable()
                        .frame(width: 18, height: 12)
                        .padding(12)
                        .background(Circle().strokeBorder(.secondary))
                }
            }
        }
        .padding([.leading, .trailing], 4)
        .padding([.top, .bottom], 6)
        .frame(height: 50)
        .background(
            ZStack {
                Capsule().fill(.white)
                Capsule().strokeBorder(Color("32304c"))
            }
        )
        .padding([.top], 6)
    }
}

struct MapRegionView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top) {
            MapRegionView(mapRegionTitle: "Philadelphia", regionFiltersDescription: "Jams · Chill · Jazz") {
            } onTapSelectRegionFilters: { }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
}
