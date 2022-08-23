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
    
    @Binding var selected: Set<Selectable>
    
    private var formattedSelectedListString: String {
        
        let count = $selected.wrappedValue.count
        switch count {
        case 0, options.count:
            return "All \(typeString)"
        case 1:
            return $selected.wrappedValue.map { optionToString($0) }.sorted().first!
        default:
            let first = $selected.wrappedValue.map { optionToString($0) }.sorted().first!
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
    struct IdentifiableString: Identifiable, Hashable {
        let string: String
        var id: String { string }
    }
    
    @State static var selected: Set<IdentifiableString> = Set(["A", "C"].map { IdentifiableString(string: $0) })
    
    static var previews: some View {
        NavigationView {
            Form {
                SelectorView<IdentifiableString>(
                    options: ["A", "B", "C", "D"].map { IdentifiableString(string: $0) },
                    optionToString: { $0.string },
                    selected: $selected
                )
            }.navigationTitle("Title")
        }
    }
}
