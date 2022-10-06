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
        NavigationView {
            VStack {
                VStack {
                    ForEach(mapRegions, id: \.self) { option in
                        Button {
                            didComplete(option)
                        } label: {
                            HStack {
                                ZStack {
                                    if option == selectedMapRegions {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color.lightBlue)
                                    }
                                }
                                .frame(width: 20)
                                Text(option)                        .fontWeight(.light)
                                    .font(.headline)
                                    .foregroundColor(option == selectedMapRegions ? Color.lightBlue : Color.accentColor)
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
                        didComplete(nil)
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color.lightBlue)
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
