//  Created by Ivan Fuertes on 16/05/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import SwiftUI

struct GuessTheFlagView: View {
    
    @ObservedObject private var viewModel: GuessTheFlagViewModel
    
    init(viewModel: GuessTheFlagViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the Flag of")
                        .foregroundColor(.white)
                    Text(viewModel.currentQuestion)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach (0..<viewModel.currentOptions.count, id: \.self) { index in
                    Button(action: {
                        self.viewModel.answer(withOption: index)
                    }) {
                       FlagImage(imageName: self.viewModel.currentOptions[index])
                    }.alert(isPresented: self.$viewModel.showGameOver) {
                        Alert(title: Text("Game Over"),
                              message: Text("Your final score is \(self.viewModel.currentScore)"),
                              dismissButton: .default(Text("Go Again!")) {
                                self.viewModel.startGame()
                            })
                    }
                }
                
                FeedbackText(message: viewModel.currentFeedback)
                
                HStack {
                    InformationView(title: "Progress", value: viewModel.currentStatus)
                        .padding(.trailing)
                        
                    InformationView(title: "Score", value: viewModel.currentScore)
                        .padding(.leading)                    
                }
                
                Spacer()
            }
        }.onAppear() {
            self.viewModel.startGame()
        }
    }
}

struct GuessTheFlagView_Previews: PreviewProvider {
    static var previews: some View {
        CompositionRoot.guessTheFlagView()
    }
}
