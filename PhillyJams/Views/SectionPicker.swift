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
    @Binding var selectedOption: String
    
    var body: some View {
        WrappingHStack(options, id:\.self) { option in
            Button {
                selectedOption = option
            } label: {
                let isSelected = option == selectedOption
                Text(option)
                    .foregroundColor(isSelected ? Color.accentColor : .black)
                    .padding([.leading, .trailing], 8)
                    .padding([.top, .bottom], 2)
                    .background(Capsule().strokeBorder(isSelected ? Color.accentColor : .secondary))
                
                    .padding([.trailing], -2)
                    .padding([.top, .bottom], 4)
            }
        }
    }
}

struct SectionPicker_Previews: PreviewProvider {
    static var previews: some View {
        SectionPicker(options: ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G"], selectedOption: .constant("Test A"))
    }
}
