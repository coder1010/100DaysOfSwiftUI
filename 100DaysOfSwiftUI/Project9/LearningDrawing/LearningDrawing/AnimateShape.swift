//
//  AnimateShape.swift
//  LearningDrawing
//
//  Created by Chhaya Ahuja on 5/19/21.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
   }
}

struct AnimateShape: View {
    
    @State private var insetAmount: CGFloat = 50
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Trapezoid(insetAmount: insetAmount)
                .frame(width: 200, height: 100)
                .background(Color.red)
                .onTapGesture {
                    withAnimation {
                        self.insetAmount = CGFloat.random(in: 10...90)
                    }
                }
            Spacer()
        }
        
        NavigationLink(destination: AnimateChecker()) {
            Text("Show Me More")
                .frame(width:188, height: 70, alignment: .center)
                .border(ImagePaint(image: Image("redHeart"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1), scale: 0.3), width: 15)
        }
        .navigationBarTitle("Blend Mode", displayMode: .inline)
    }
}

struct AnimateShape_Previews: PreviewProvider {
    static var previews: some View {
        AnimateShape()
    }
}
