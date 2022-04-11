//
//  NumberView.swift
//  Edutainment
//
//  Created by Chhaya Ahuja on 5/3/21.
//

import SwiftUI

struct NumberView: View {
    @State  var animationAmount = 0.0
    @State  var numberDisplayed = "1"
    @State var imageName = ""
    var body: some View {
        ZStack {
            Button(action: {
                //tappedIndex = tag
                withAnimation(){
                    animationAmount += 360.0
                }
                
            }){
                Image(imageName)
                    .resizable()
                    .renderingMode(.original)
            }
            .frame(width: 50, height: 50, alignment: .center)
            .scaleEffect(1)
            
            Text("\(numberDisplayed)")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.black)
                .padding(.all)
                .frame(height: nil)
        }
        
    }
    
}

struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        NumberView()
    }
}
