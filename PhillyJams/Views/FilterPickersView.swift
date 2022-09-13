//
//  FilterPickersView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/13/22.
//

import SwiftUI

struct FilterPickersView: View {
    let title: String = "Title"
    
    let options: [String] = ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G", "Test H"]
    @State var selectedOption: String = "Test A"
    
//    @Binding var showView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 86)
                Spacer()
                Text(title)
                    .font(.headline)
                Spacer()
                Button {
//                    showView = false
                } label: {
                    Text("Done")
                }
//                .padding([.trailing], 24)
                .frame(width: 86)
            }
            .padding([.top], 24)
            
            List {
                Section("Section") {
                    HStack {
                        ForEach(options, id:\.self) { option in
                            Button {
                                
                            } label: {
                                let isSelected = option == selectedOption
                                Text(option)
                                    .foregroundColor(isSelected ? Color.accentColor : .black)
                                .padding([.leading, .trailing], 8)
                                .padding([.top, .bottom], 2)
                                .background(Capsule().strokeBorder(isSelected ? Color.accentColor : .secondary))
                            }
                        }
                    }
                }
                
            }
        }
    }
}

struct FilterPickersView_Previews: PreviewProvider {
    static var previews: some View {
        FilterPickersView()
    }
}
