//
//  MultiSelectView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/15/22.
//

import SwiftUI

//enum SelectorType {
//    case list, rangeSlider
//}

struct SelectorView: View {
    var typeString: String = ""
    let options: [String]
//    let selectorType: SelectorType
    
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
            NavigationLink {
//                switch selectorType {
//                case .list:
                    MultiSelectionView(
                        title: typeString,
                        options: options,
                        selected: $selected
                    )
//                case .rangeSlider:
//                    SliderView(
//                        title: typeString,
//                        options: options,
//                        selected: $selected
//                    )
//                }
            } label: {
                Text(formattedSelectedListString)
                    .font(.system(size: 15))
                    .padding(6)
            }
        }
        .padding([.leading, .trailing], 8)
        .background(Capsule().strokeBorder(.secondary))
        .frame(idealHeight: 44)
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
