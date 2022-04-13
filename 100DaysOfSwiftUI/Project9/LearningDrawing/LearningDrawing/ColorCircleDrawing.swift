//
//  ColorCircleDrawing.swift
//  LearningDrawing
//
//  Created by Chhaya Ahuja on 5/13/21.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 5

    var body: some View {
        
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    //.strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 35)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


struct ColorCircleDrawing: View {
    
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
                .padding()
            Slider(value: $colorCycle)
            
            Spacer()
            NavigationLink(destination: SpecialEffects()) {
                Text("Show More")
                    .frame(width:188, height: 70, alignment: .center)
                    .border(ImagePaint(image: Image("redHeart"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1), scale: 0.3), width: 15)
            }
        }
        .navigationBarTitle("ColorCircle", displayMode: .inline)
    }
}

struct ColorCircleDrawing_Previews: PreviewProvider {
    static var previews: some View {
        ColorCircleDrawing()
    }
}
