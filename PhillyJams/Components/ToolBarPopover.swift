//
//  ToolBarPopover.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/16/22.
//

import SwiftUI

extension View{
    
    func toolBarPopover<Content: View>(show: Binding<Bool>, xPosition: CGFloat = 0, @ViewBuilder content: @escaping ()->Content ) -> some View {
        
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                
                ZStack(alignment: .topLeading) {
                    
                    if show.wrappedValue{
                        
                        Rectangle()
                            .fill(Color.black.opacity(0.01))
                            .onTapGesture {
                                withAnimation {
                                    show.wrappedValue.toggle()
                                }
                            }
                        
                        content()
                            .padding()
                            .background(
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            )
                            .shadow(color: Color.primary.opacity(0.05), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.primary.opacity(0.05), radius: 5, x: -5, y: -5)
                            .padding(.horizontal,35)
                            .padding(.bottom,60)
                            .offset(x: xPosition - 35, y: 42)
                    }
                }
            )
    }
}
