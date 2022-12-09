//
//  RegionPicker.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/12/22.
//

import SwiftUI
import MusicVenues

struct RegionPicker: View {
    let title: String
    let regions: [Region]
    @Binding var selectedRegion: Region
    @Binding var isShowing: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    ForEach(regions, id: \.self) { region in
                        Button {
                            selectedRegion = region
                            isShowing = false
//                            didComplete(option)
                        } label: {
                            HStack {
                                ZStack {
                                    if region == selectedRegion {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color.lightBlue)
                                    }
                                }
                                .frame(width: 20)
                                Text(region.title)
                                    .fontWeight(.light)
                                    .font(.headline)
                                    .foregroundColor(region == selectedRegion ? region.color : Color.accentColor)
                                Spacer()
                            }
                            .padding([.leading], 12)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding([.top, .bottom], 8)
                }
                .padding([.top, .bottom], 12)
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 12, height: 12))
                        .foregroundColor(.white)
                        .shadow(color: Color.accentColor.opacity(0.25), radius: 8)
                )
                .padding([.leading, .trailing], 12)
                .padding([.bottom], 8)
                
                Spacer()
            }
            .padding([.top], 12)
            .background(.regularMaterial)
            .navigationBarTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        isShowing = false
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color.lightBlue)
                    }
                }
            }
        }
    }
}

struct RegionPicker_Previews: PreviewProvider {
    static var previews: some View {
        
        let region = Region.preview
        RegionPicker(title: region.title,
                    regions: [region, region, region],
                     selectedRegion: .constant(region),
                     isShowing: .constant(true))
    }
}
