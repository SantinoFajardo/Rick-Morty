//
//  CharactersListView.swift
//  RickMorty
//
//  Created by Santino Fajardo on 28/03/2023.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject private var controller = CharacterController()
    @State private var selectedCharacterId: Character?
    @State private var sheet = false
    @State private var color = Color("Black")
    @State private var isLoading = false
    
    var body: some View{
        ZStack {
            NavigationView {
                List {
                    Section {
                        ForEach(controller.characters) { character in
                            HStack{
                                URLImage(url: character.image)
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(30)
                                VStack(alignment: .leading) {
                                    if let name = character.name {
                                        Text(name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                    if let species = character.species{
                                        Text(species)
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                    }
                                    
                                }
                                Button(action: {
                                    self.selectedCharacterId = character
                                    if let _ = controller.character, self.isLoading != true {
                                        self.sheet = true
                                        
                                    }
                                }) {
                                    VStack{
                                        Image(systemName: "greaterthan")
                                            .foregroundColor(.gray)
                                    }
                                    .frame(maxWidth: .infinity,alignment: .trailing)
                                }.task {
                                    self.isLoading = true
                                    controller.getCharacterDetail(id: character.id)
                                    self.isLoading = false
                                }
                            }.frame(height:75).listRowBackground(Color("Black"))
                        }
                    }
                }.padding(.top,20)
                    .background(Color("Background"))
                    .scrollContentBackground(.hidden)
                    .sheet(isPresented:$sheet){
                        if let character = selectedCharacterId, let _ = controller.character,self.isLoading != true {
                            ZStack {
                                Color("Black").ignoresSafeArea()
                                VStack{
                                    VStack{
                                        Button(action:{
                                            self.sheet = false
                                        }){
                                            Image(systemName: "xmark")
                                                .foregroundColor(.white)
                                                .padding()
                                        }
                                    }
                                    .frame(maxWidth: .infinity,alignment: .trailing)
                                    
                                    CharacterDetailView(character:character,episodes: character.episode)
                                }
                            }
                            .presentationDetents([.fraction(0.40),.fraction(1)])
                            .presentationDragIndicator(.visible)
                        }else{
                            ZStack{
                                Color("Black").ignoresSafeArea()
                                Text("Loading...")
                                
                            }
                        }
                    }
                    .task {
                        controller.getCharacters()
                    }
            }.overlay(
                NavigationBar()
            )
        }
        
    }
}

// Load and show the image
struct URLImage: View {
    let url: String
    
    // Loaded image
    @State private var image: UIImage? = nil
    
    // Error handling
    @State private var errorMessage: String? = nil
    
    var body: some View {
        if let errorMessage = errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
        } else if let image = image {
            Image(uiImage: image)
                .resizable()
        } else {
            Color.gray
                .onAppear {
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: url) else {
            errorMessage = "Invalid URL"
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                errorMessage = "Error downloading image"
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

struct NavigationBar: View {
    var body: some View{
        ZStack{
            Color("Black")
                .ignoresSafeArea(.all)
                .blur(radius: 10)
                .background(.ultraThinMaterial)
                .blur(radius: 10)
            
            Image("Logo")
                .resizable()
                .frame(width: 200,height: 75)
                .padding(.leading,20)
                .padding(.top,-20)
                .foregroundColor(Color("Green"))
                .italic()
        }
        .frame(height: 80)
        .frame(maxHeight: .infinity,alignment: .top)
    }
}


struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
