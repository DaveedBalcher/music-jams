//
//  SectionPicker.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/13/22.
//

import SwiftUI
import WrappingHStack

struct SectionPicker: View {
    @ObservedObject var vm: SectionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                vm.didToggleSelectAll()
            } label: {
                let isSelected = vm.selectAllIsSelected()
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
                    .padding([.bottom], -4)
            }
            
            WrappingHStack(vm.options, id:\.self) { option in
                Button {
                    vm.didToggleOptionSelection(for: option)
                } label: {
                    let isSelected = vm.optionIsSelected(for: option)
                    Text(option.capitalized)
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
                        .padding([.top, .bottom], 4)
                }
            }
        }
    }
}

struct SectionPicker_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SectionViewModel(type: "Test", options: ["Test A", "Test B", "Test C", "Test D", "Test E", "Test F", "Test G"], selectedOption: (["Test A"]))
        SectionPicker(vm: vm)
    }
}
