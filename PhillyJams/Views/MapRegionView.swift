//
//  NeighborhoodView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/12/22.
//

import SwiftUI

struct MapRegionView: View {
    let mapRegionTitle: String
    let mapRegionColor: Color?
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
                    .padding([.leading], 8)
                    .padding([.trailing], 4)
                
                VStack(alignment: .leading) {
                    Text(mapRegionTitle)
                        .foregroundColor(mapRegionColor ?? Color.accentColor)
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
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).strokeBorder(.secondary))
                }
                .padding([.trailing], 4)
            }
        }
        .padding([.leading, .trailing], 8)
        .padding([.top, .bottom], 6)
        .frame(height: 50)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(.white)
                RoundedRectangle(cornerRadius: 8).strokeBorder(Color("32304c").opacity(0.25))
            }
            .shadow(color: Color("32304c").opacity(0.25), radius: 8)
        )
        .padding([.top], 6)
    }
}

struct MapRegionView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top) {
            MapRegionView(mapRegionTitle: "Philadelphia", mapRegionColor: nil, regionFiltersDescription: "Jams · Chill · Jazz") {
            } onTapSelectRegionFilters: { }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
}
