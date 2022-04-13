//
//  AnimateChecker.swift
//  LearningDrawing
//
//  Created by Chhaya Ahuja on 5/19/21.
//

import SwiftUI

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)

        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}

struct AnimateChecker: View {
    
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    self.rows = 8
                    self.columns = 16
                }
            }
        NavigationLink(destination: AnimateSpirograph()) {
            Text("Show Me More")
                .frame(width:188, height: 70, alignment: .center)
                .border(ImagePaint(image: Image("redHeart"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 1), scale: 0.3), width: 15)
        }
        .navigationBarTitle("Animating Checker", displayMode: .inline)
    }
}

struct AnimateChecker_Previews: PreviewProvider {
    static var previews: some View {
        AnimateChecker()
    }
}
