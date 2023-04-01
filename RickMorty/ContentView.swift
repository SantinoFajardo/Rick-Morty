//
//  ContentView.swift
//  RickMorty
//
//  Created by Santino Fajardo on 28/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isTrue: Bool = true
    var body: some View {
        
        NavigationView {
            NavigationLink(destination: CharacterListView().navigationBarBackButtonHidden(true),
                           label: {
                ZStack {
                    Color("Background").ignoresSafeArea()
                    VStack{
                        Spacer()
                        Image("Rick&Morty")
                            .resizable()
                            .frame(width: 300, height: 300)
                        Text("Start")
                            .bold()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 18))
                            .background(Color("Black"))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        HStack{
                            Text("Created by:")
                                .foregroundColor(.white)
                            Text("SANTINO FAJARDO")
                                .foregroundColor(Color("Green"))
                                .bold()
                        }
                        Spacer()
                    }
                }

            })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
