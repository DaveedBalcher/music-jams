//
//  MultiSelectView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/15/22.
//

import SwiftUI

struct SelectorView<Selectable: Identifiable & Hashable>: View {
    var typeString: String = ""
    let options: [Selectable]
    let optionToString: (Selectable) -> String
    
    @Binding var selected: Set<String>
    
    private var formattedSelectedListString: String {
        
        let count = $selected.wrappedValue.count
        switch count {
        case 0, options.count:
            return "All \(typeString)"
        case 1:
            return $selected.wrappedValue.sorted().first!
        default:
            let first = $selected.wrappedValue.sorted().first!
            return first + " +\(count-1)"
        }
    }
    
    var body: some View {
        HStack {
            NavigationLink(destination: multiSelectionView()) {
                Text(formattedSelectedListString)
                    .font(.system(size: 15))
                    .padding(6)
            }
        }
        .padding([.leading, .trailing], 8)
        .background(Capsule().strokeBorder(.secondary))
        .frame(idealHeight: 44)
    }
    
    private func multiSelectionView() -> some View {
        MultiSelectionView(
            title: typeString,
            options: options,
            optionToString: optionToString,
            selected: $selected
        )
    }
}

struct MultiSelector_Previews: PreviewProvider {
    @State static var selected: Set<String> = Set(["A", "C"])
    
    static var previews: some View {
        NavigationView {
            Form {
                SelectorView(
                    options: ["A", "B", "C", "D"],
                    selected: $selected
                )
            }.navigationTitle("Title")
        }
    }
}
