//
//  ContentView.swift
//  Animations
//
//  Created by Chhaya Ahuja on 4/27/21.
//

import SwiftUI
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}
//1. Implicit Animation (Enlarges & Blurs Red Button)
struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var animatAmount: CGFloat = 0.5
    @State private var animAmount = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var dragAmount1 = CGSize.zero
    @State private var isShowingRed = false

    let letters = Array("Hello SwiftUI")
    
    var body: some View {
        VStack{
            HStack(spacing: 0) {
                ForEach(0..<letters.count) { num in
                    Text(String(self.letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(self.enabled ? Color.blue : Color.red)
                        .offset(self.dragAmount1)
                        .animation(Animation.default.delay(Double(num) / 20))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount1 = $0.translation }
                    .onEnded { _ in
                        self.dragAmount1 = .zero
                        self.enabled.toggle()
                    }
            )
            HStack{
                Button("Tap Me") {
                    self.animatAmount += 0.5
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animatAmount)
                .animation(.default)
                //.blur(radius: (animationAmount - 1) * 3)
                Spacer()
                Button("Tap Me") {
                    self.enabled.toggle()
                }
                .frame(width: 100, height: 100)
                .background(enabled ? Color.blue : Color.red)
                .foregroundColor(.white)
                .animation(nil)
                .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                .animation(.interpolatingSpring(stiffness: 10, damping: 1))
            }
            .padding()
            HStack{
                Button("Tap Me") {
                    // self.animationAmount += 1
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.red)
                        .scaleEffect(animationAmount)
                        .opacity(Double(2 - animationAmount))
                        .animation(
                            Animation.easeOut(duration: 1)
                                .repeatForever(autoreverses: false)
                        )
                )
                .onAppear {
                    self.animationAmount = 2
                }
                
                Spacer()
                
                Button("Tap Me") {
                   // withAnimation {
                    withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                        self.animAmount += 360
                    }
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(animAmount), axis: (x: 0, y: 1, z: 0))
            }
            .padding()
            HStack{
                LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .padding(30)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { self.dragAmount = $0.translation }
                            .onEnded {_ in
                                withAnimation(.spring()) {
                                    self.dragAmount = .zero
                                } }
                    )
                Spacer()
                Button("Tap Me") {
                    withAnimation{
                        self.isShowingRed.toggle()
                    }
                }
                if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 120, height: 120)
                        //.transition(.scale)
                        //.transition(.asymmetric(insertion: .scale, removal: .opacity))
                        .transition(.pivot)
                }
            }
            
        }
    }
}

//2. Customizing Animation (Circle Button Radio Wave Effect)
struct ContentView2: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        Button("Tap Me") {
             self.animationAmount += 2
        }
        .padding(40)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        //.repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            self.animationAmount = 2
        }
    }
}


//3. Animation Binding (Stepper increses size of red button)
struct ContentView3: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        VStack {
            //Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)
            
            Spacer()

            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

//4. Explicit Animation (Spin Effect)
struct ContentView4: View {
    @State private var animationAmount = 0.0
    var body: some View {
        Button("Tap Me") {
           // withAnimation {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}



//5. Controlling Animation Stack (Rect to Round Corners)
struct ContentView5: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                self.enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? Color.blue : Color.red)
            .foregroundColor(.white)
            .animation(nil)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1))
        }
    }
}

//6. Animating Gestures (Card Drag Effect)
struct ContentView6: View {
    
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded {_ in
                        withAnimation(.spring()) {
                            self.dragAmount = .zero
                        } }
            )
            //.animation(.spring())
        
    }
}

//7. Letters Snake Effect
struct ContentView7: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
                }
        )
    }
}

//8. Showing/Hiding Views
struct ContentView8: View {
    @State private var isShowingRed = false
    
    var body: some View {
            VStack {
                Button("Tap Me") {
                    withAnimation{
                        self.isShowingRed.toggle()
                    }
                }
                if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 200, height: 200)
                        //.transition(.scale)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
        }
}

//9. Building custom transitions using ViewModifier (Rectangle opens and closes)
/*struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView9: View {
    @State private var isShowingRed = false
    
    var body: some View {
            VStack {
                Button("Tap Me") {
                    withAnimation{
                        self.isShowingRed.toggle()
                    }
                }
                if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 200, height: 200)
                        //.transition(.scale)
                        //.transition(.asymmetric(insertion: .scale, removal: .opacity))
                        .transition(.pivot)
                }
            }
        }
}*/

                

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView2()
        ContentView3()
        ContentView4()
        ContentView5()
        ContentView6()
        ContentView7()
        ContentView8()
    }
}
