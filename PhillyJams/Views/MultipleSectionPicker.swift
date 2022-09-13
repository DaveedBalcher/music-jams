//
//  FilterPickersView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/13/22.
//

import SwiftUI
import WrappingHStack

struct MultipleSectionPicker: View {
    let title: String = "Title"
    let section: String = "Section"
    let options: [String] = ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G"]
    @State var selectedOptions = "Test A"
    
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
            
            VStack(alignment: .leading) {
                Text(section)
                SectionPicker(options: options, selectedOption: $selectedOptions)
            }
            .padding()
            .background(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)).foregroundColor(.white))
            .padding()
        }
        .background(.regularMaterial)
    }
}

struct FilterPickersView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSectionPicker()
    }
}
