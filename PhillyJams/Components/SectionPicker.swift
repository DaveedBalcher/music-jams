//
//  SectionPicker.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/13/22.
//

import SwiftUI
import WrappingHStack

struct SectionPicker: View {
    let options: [String]
    @Binding var selectedOption: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                selectedOption = nil
            } label: {
                let isSelected = selectedOption == nil
                Text("All")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(isSelected ? Color.lightBlue : Color.accentColor)
                    .padding([.leading, .trailing], 8)
                    .padding([.top, .bottom], 2)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(isSelected ? Color.lightBlue : Color.accentColor.opacity(0.5))
                    )
                    .padding([.trailing], -2)
                    .padding([.bottom], -4)
            }
            
            WrappingHStack(options, id:\.self) { option in
                Button {
                    selectedOption = option
                } label: {
                    let isSelected = selectedOption == option
                    Text(option)
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(isSelected ? Color.lightBlue : Color.accentColor)
                        .padding([.leading, .trailing], 8)
                        .padding([.top, .bottom], 2)
                        .background(Capsule().strokeBorder(isSelected ? Color.lightBlue : .black.opacity(0.5)))
                    
                        .padding([.trailing], -2)
                        .padding([.top, .bottom], 4)
                }
            }
        }

    }
    
    
}

struct SectionPicker_Previews: PreviewProvider {
    static var previews: some View {
        SectionPicker(options: ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G"], selectedOption: .constant("Test A"))
    }
}
