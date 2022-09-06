//
//  SliderView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/2/22.
//

//import SwiftUI
//import MusicVenues
//import RangeUISlider
//
//struct SliderView: View {
//
//    private let title: String
//    private let options: [String]
//    private var firstOptionString: String {
//        options.first ?? ""
//    }
//    private var lastOptionString: String {
//        options.last ?? ""
//    }
//    private var initialMinValue: CGFloat {
//        0
//    }
//    private var initialMaxValue: CGFloat {
//        CGFloat(options.count-1)
//    }
//
//    @Binding private var selected: Set<String>
//    @State private var minValueSelected: CGFloat = 0
//    @State private var maxValueSelected: CGFloat
//
//    internal init(title: String, options: [String], selected: Binding<Set<String>>) {
//        self.title = title
//        self.options = options
//
//        _selected = selected
//        _maxValueSelected = State(initialValue: CGFloat(options.count-1))
//    }
//
//    var body: some View {
//
//        HStack {
//            Text(firstOptionString)
//            RangeSlider(minValueSelected: $minValueSelected, maxValueSelected: $maxValueSelected)
//                .stepIncrement(1)
//                .scaleMinValue(initialMinValue)
//                .scaleMaxValue(initialMaxValue)
//                .defaultValueLeftKnob(initialMinValue)
//                .defaultValueRightKnob(initialMaxValue)
//                .onChange(of: minValueSelected) { _ in
//                    didSelectRange()
//                }
//                .onChange(of: maxValueSelected) { _ in
//                    didSelectRange()
//                }
////                .leftKnobWidth(40)
////                .leftKnobHeight(40)
////                .leftKnobCorners(20)
////                .rightKnobColor(Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)))
////                .rightKnobWidth(40)
////                .rightKnobHeight(40)
////                .rightKnobCorners(20)
//
//            Text(lastOptionString)
//        }
//        .padding()
//    }
//
//    func didSelectRange() {
//        let range = options[Int(minValueSelected)..<Int(maxValueSelected)]
//        selected = Set(range)
//    }
//}
//
////struct SliderView_Previews: PreviewProvider {
////    static var previews: some View {
////        SliderView(title: "Vibe",
////                   options: VibeType.allCases.rawValues,
////                   minValueSelected: .constant(0),
////                   maxValueSelected: .constant(4))
////    }
////}
