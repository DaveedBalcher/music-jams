//
//  FilterView.swift
//  MusicJams (iOS)
//
//  Created by Daveed Balcher on 8/1/22.
//

import SwiftUI

struct ToggleView<T: Hashable>: View {
    @Binding var selected: T
    @Binding var options: [T]
    var name: (_ option: T)->(String)
    var didChange: ()->Void
    
    var body: some View {
        
        HStack {
            Picker("", selection: $selected) {
                ForEach(options, id: \.self) { option in
                    Text(name(option))
                        .tag(option)
                }
            }
            .onChange(of: selected) { _ in
                didChange()
            }
        }
        .padding([.leading, .trailing], 12)
        .background(Capsule().strokeBorder(.secondary))
        .frame(idealHeight: 44)
    }
}

//struct ToggleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToggleView()
//    }
//}
