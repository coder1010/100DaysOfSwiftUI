//
//  PhotoEffects.swift
//  LearningDrawing
//
//  Created by Chhaya Ahuja on 5/19/21.
//

import SwiftUI

struct PhotoEffects: View {
    @State private var amount: CGFloat = 0.0

        var body: some View {
            VStack {
                Image("nooyi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 300)
                    .saturation(Double(amount))
                    .blur(radius: (1 - amount) * 20)

                Slider(value: $amount)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            NavigationLink(destination: AnimateShape()) {
                Text("Show Me More")
                    .frame(width:188, height: 70, alignment: .center)
                    .border(ImagePaint(image: Image("redHeart"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1), scale: 0.3), width: 15)
            }
            
            
        
        .navigationBarTitle("Blend Mode", displayMode: .inline)
            
        }
}

struct PhotoEffects_Previews: PreviewProvider {
    static var previews: some View {
        PhotoEffects()
    }
}
