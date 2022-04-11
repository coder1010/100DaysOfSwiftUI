//
//  ContentView.swift
//  Edutainment
//
//  Created by Chhaya Ahuja on 4/30/21.
//

import SwiftUI

struct ContentView: View {
    
    let options = ["5", "10", "20", "All"]
    @State private var table = 0
    @State private var questions = 0
    @State private var scaleAmount = 1
    
    @State private var isGameActive = false
    @State private var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    @State private var showAnswerAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var multiplyNumber = 1
    @State private var userAnswer = ""
    
    @State private var correctAnswers = 0
    @State private var questionCount = 0
    
    @State private var animationAmount = 0.0
    @State private var animation: CGFloat = 1

    func restart() {
        table = 0
        questions = 0
        isGameActive = false
        correctAnswers = 0
        questionCount = 0
    }
    
    func generateQuestions() {
        multiplyNumber = numbers.randomElement() ?? 1
        userAnswer = ""
        questionCount += 1
    }
    
    func checkAnswer() {
        showAnswerAlert = true
        if(table * multiplyNumber == Int(userAnswer)) {
            correctAnswers += 1
            alertTitle = "Correct!"
            print(numbers.firstIndex(of: multiplyNumber) as Any)
            print(numbers)
            let index = numbers.firstIndex(of: multiplyNumber) ?? 0
            numbers.remove(at: index)
            print(numbers)
        }
        else {
            alertTitle = "Try Again!"
        }
        alertMessage = "\(correctAnswers)/\(options[questions])"
        
    }
    
    func tableSelected(_ index: Int) {
        table = index
        print(table)
    }
    struct user {
        var name : String
    }
    var body: some View {
        NavigationView {
            VStack (alignment:.center) {
                
                    if !isGameActive {
                        
                        Section(header: Text("Choose table")
                                    .font(.largeTitle)
                                    .foregroundColor(.yellow)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)){
                            HStack{
                                ForEach(1 ..< 5) { index in
                                    ZStack {
                                        Button(action: {
                                            withAnimation(){
                                                table = index
                                                animationAmount += 360.0
                                                scaleAmount = 1
                                            }
                                            
                                            tableSelected(index)
                                        }){
                                            Image("\(index)")
                                                .resizable()
                                                .renderingMode(.original)
                                                .overlay(index == table ? Ellipse().stroke(Color.black, lineWidth: 1) : nil)
                                        }
                                        .frame(width: 70, height: 70, alignment: .center)
                                        .scaleEffect(index == table ? 1.2 : 1)
                                        
                                        .rotation3DEffect(.degrees(index == table ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                                        Text("\(index)")
                                            .font(.largeTitle)
                                            .fontWeight(.heavy)
                                            .foregroundColor(Color.black)
                                            .frame(height: nil)
                                    }
                                }
                            }
                            HStack{
                            ForEach(5 ..< 9) { index in
                                ZStack {
                                    Button(action: {
                                        scaleAmount = 2
                                       tableSelected(index)
                                    }){
                                        Image("\(index)")
                                            .resizable()
                                            .renderingMode(.original)
                                    }
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                    Text("\(index)")
                                        .font(.largeTitle)
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color.black)
                                        .frame(height: nil)
                                }
                            }
                        }
                        HStack{
                            ForEach(9 ..< 13) { index in
                                ZStack {
                                    Button(action: {
                                        scaleAmount = 2
                                       tableSelected(index)
                                    }){
                                        Image("\(index)")
                                            .resizable()
                                            .renderingMode(.original)
                                    }
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                    Text("\(index)")
                                        .font(.largeTitle)
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color.black)
                                }
                            }
                        }
                        }
                        Spacer()
                            Section(header: Text("Select Questions")
                                        .font(.largeTitle)
                                        .foregroundColor(.yellow)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)) {
                                    Picker("Select input Unit", selection: $questions) {
                                        ForEach(0 ..< options.count) { index in
                                            Text("\(options[index])")
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                            }
                        Spacer()
                        Section(header: Text("Let's Go")
                                    .font(.largeTitle)
                                    .foregroundColor(.yellow)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)) {
                                Button(action: {
                                    isGameActive = true
                                    generateQuestions()
                                }){
                                    ZStack{
                                        Image("1")
                                            .renderingMode(.original)
                                        Text("Start")
                                            .font(.title3)
                                            .fontWeight(.heavy)
                                            .foregroundColor(Color.black)
                                    }
                                    
                                    
                                }
                            }
                        Spacer()
                    }
                if isGameActive {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.white, .yellow]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)
                    VStack{
                        HStack{
                            Button("\(table)") {
                                 self.animation += 2
                            }
                            .padding(40)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.yellow)
                                    .scaleEffect(animation)
                                    .opacity(Double(2 - animation))
                                    .animation(
                                        Animation.easeIn(duration: 3)
                                    )
                            )
                            .onAppear {
                                self.animation = 2
                            }
                            Text("*")
                            Button("\(multiplyNumber)") {
                                 self.animation += 2
                            }
                            .padding(40)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.yellow)
                                    .scaleEffect(animation)
                                    .opacity(Double(2 - animation))
                                    .animation(
                                        Animation.easeIn(duration: 3)
                                    )
                            )
                            .onAppear {
                                self.animation = 2
                            }
                        }
                        .padding()
                        Text("=")
                        
                        TextField("Answer", text:$userAnswer, onCommit: checkAnswer)
                            .padding(.leading, 180.0)
                        
                        Spacer()
                    }
                    }
                    .alert(isPresented:$showAnswerAlert){
                        Alert(title: Text(alertTitle),
                              message: Text(alertMessage),
                              dismissButton: .default(Text("Continue")){
                                if(questionCount == Int(options[questions])) {
                                    restart()
                                }
                                else {
                                    generateQuestions()
                                }
                              })
                    }
                }
            }
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Restart") {
                       restart()
                    }
                }
            }
        }
        
                    
                    
                /*Button(action: {
             lowerTable = tag
             self.generateQuestion(_index: tag)
             isGameActive = true
         }){
             Image("\(tag)")
                 .resizable()
                 .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                 .shadow(color: .black, radius: 3)
         }
         .padding(5)
         .clipShape(Circle())
         .alert(isPresented:$isGameActive){
             Alert(title: Text("\(lowerTable)"),
                   message: Text("Hello"),
                   dismissButton: .default(Text("Continue")){
                     //reset()
                   })
         }
         Text("\(tag+1)")
             .font(.title)
             .padding(5)
     }
     .overlay(Rectangle().stroke(Color.red, lineWidth: 5))
             
             
             HStack{
                        ForEach(3..<6) { tag in
                            VStack {
                                Button(action: {
                                    self.generateQuestion(_index: tag)
                                }){
                                    Image("\(tag)")
                                        .resizable()
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                                        .shadow(color: .black, radius: 3)
                                }
                                .padding(5)
                                Text("\(tag+1)")
                                    .font(.title)
                                    .padding(5)
                            }
                            .overlay(Rectangle().stroke(Color.red, lineWidth: 5))
                        }
                    }
                    
                    
                    HStack{
                        ForEach(6..<9) { tag in
                            VStack {
                                Button(action: {
                                    self.generateQuestion(_index: tag)
                                }){
                                    Image("\(tag)")
                                        .resizable()
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                                        .shadow(color: .black, radius: 3)
                                }
                                .padding(5)
                                Text("\(tag+1)")
                                    .font(.title)
                                    .padding(5)
                            }
                            .overlay(Rectangle().stroke(Color.red, lineWidth: 5))
                        }
                    }
                    
                    HStack{
                        ForEach(9..<12) { tag in
                            VStack {
                                Button(action: {
                                    self.generateQuestion(_index: tag)
                                }){
                                    Image("\(tag)")
                                        .resizable()
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                                        .shadow(color: .black, radius: 3)
                                }
                                .padding(5)
                                Text("\(tag+1)")
                                    .font(.title)
                                    .padding(5)
                            }
                            .overlay(Rectangle().stroke(Color.red, lineWidth: 5))
                        }
                    }*/
                    
            }
            
               // Section(header: Text("How many questions should we ask?") ){
                
          //  }
       // }
            
                
                
                //Spacer()
           // }
           // .foregroundColor(.black)
          //  .navigationBarTitle("EDUTAINMENT", displayMode: .inline)
        //}
    //}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
