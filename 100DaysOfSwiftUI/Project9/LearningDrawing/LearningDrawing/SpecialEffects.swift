//
//  SpecialEffects.swift
//  LearningDrawing
//
//  Created by iChaya2.0 on 5/19/21.
//

import SwiftUI

struct SpecialEffects: View {
    @State private var colorEffect = false
    var body: some View {
        VStack {
            Spacer()
            Toggle("Apply Blend Color", isOn: $colorEffect)
            Image("nooyi")
                .resizable()
                .frame(width: 400, height: 300, alignment: .center)
                .colorMultiply(colorEffect ? .red : .white)
            Spacer()
            NavigationLink(destination: BlendingCircles()) {
                Text("Show Me More")
                    .frame(width:188, height: 70, alignment: .center)
                    .border(ImagePaint(image: Image("redHeart"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1), scale: 0.3), width: 15)
            }
            
            
        }
        .navigationBarTitle("Blend Mode", displayMode: .inline)
    }
}

struct SpecialEffects_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffects()
    }
}
