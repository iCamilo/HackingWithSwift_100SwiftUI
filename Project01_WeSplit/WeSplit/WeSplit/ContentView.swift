//
//  ContentView.swift
//  WeSplit
//
//  Created by Ivan Fuertes on 12/04/20.
//  Copyright © 2020 Ivan Fuertes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var barca = ""
    private let names = ["Xavi", "Iniesta", "Busquets", "Puyol", "Valdez", "Henry", "Zlatan", "Macherano", "Messi", "Etho", "Alvez"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Favorite Barca Player")) 
                {
                    Picker("Select Your Favorite", selection: $barca) {
                        ForEach(names, id: \.self) {
                            Text($0)
                        }
                    }
                    Text("You selected \(barca)")
                }
                .font(.title)
                                    
                Section(header: Text("2 Way Binding"))
                {
                    TextField("Tell me your name", text: $name)
                    Text("Your name is \(name)")
                }
                .font(.title)
                
                Section(header: Text("For Each"))
                {
                    ForEach(names, id: \.self) {
                        Text("Barcelon dream player \($0)")
                    }
                }
                .font(.title)
            }
            .navigationBarTitle("Title", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

