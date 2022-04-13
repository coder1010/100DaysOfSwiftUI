//
//  ContentView.swift
//  LearningDrawing
//
//  Created by iChaya2.0 on 5/12/21.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}




struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Drawing Lessons Day 43-46 #100daysofswiftui")
                    .padding()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                HStack {
                    Path { path in
                        path.move(to: CGPoint(x: 50, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: 100))
                        path.addLine(to: CGPoint(x: 100, y: 100))
                        path.addLine(to: CGPoint(x: 50, y: 0))
                        
                    }
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    
                    Path { path in
                        path.move(to: CGPoint(x: 30, y: 100))
                        path.addLine(to: CGPoint(x: 30, y: 30))
                        path.addLine(to: CGPoint(x: 100, y: 30))
                        path.addLine(to: CGPoint(x: 100, y: 100))
                        path.addLine(to: CGPoint(x: 30, y: 100))
                    }
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    
                    Triangle()
                        //.fill(Color.red)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .frame(width: 100, height: 100)
                    
                    
                    
                    Circle()
                        .strokeBorder(Color.blue, lineWidth: 40)
                }
                ZStack {
                    //NavigationLink(destination: SpecialEffects()) {
                    NavigationLink(destination: FlowerDrawing()) {
                        Text("Show More")
                            .frame(width:188, height: 70, alignment: .center)
                            .border(ImagePaint(image: Image("redHeart"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1), scale: 0.3), width: 15)
                    }
                    Arc(startAngle: .degrees(-120), endAngle: .degrees(120), clockwise: true, insetAmount: 10)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                }
                
                
            }
            .navigationBarTitle("Drawings", displayMode: .inline)
        }

        
       /* Capsule()
            .strokeBorder(ImagePaint(image: Image("example"), scale: 0.1), lineWidth: 20)
            .frame(width: 300, height: 200)*/
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
