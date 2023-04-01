//
//  CharacterDetailView.swift
//  RickMorty
//
//  Created by Santino Fajardo on 28/03/2023.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject private var controller = CharacterController()
    @State private var character: Character
    @State private var characterDetail: CharacterDetail?
    @State private var stringEpisodes: [String]
    init(character: Character,episodes: [String]) {
        self.character = character
        self.stringEpisodes = episodes
    }
    @State private var isSheet = false
    @State private var selectedEpisode: Episodes?
    
    
    var body: some View {
        
        ZStack {
            Color("Black").ignoresSafeArea()
            VStack{
                URLImage(url: character.image).frame(width: 175,height: 175).cornerRadius(87.5)
                VStack(spacing:10){
                    Text(character.name).foregroundColor(.white).bold().font(.title)
                    Text("Gender: \(character.gender)").foregroundColor(.white)
                    Text("Specie: \(character.species)").foregroundColor(.white)
                    Text("Status: \(character.status)").foregroundColor(.white)
                    if let episodes = controller.character.episode {
                        Text("Episodes where appear:").foregroundColor(.white).font(.title2).bold().padding(.top,10).padding(.bottom,-10)
                        VStack {
                            List{
                                ForEach(episodes) { episode in
                                    Section{
                                        Button(action:{
                                            self.isSheet = true
                                            self.selectedEpisode = episode
                                        }){
                                            Text(episode.name).foregroundColor(.black)
                                        }
                                        .sheet(isPresented: $isSheet, content: {
                                            EpisodeDetailView(episode: selectedEpisode ?? episode)
                                                .presentationDetents([.fraction(0.20)])
                                                .presentationDragIndicator(.visible)
                                        })
                                    }
                                }.listRowBackground(Color("Green"))
                            }
                            
                        }
                        .background(Color("Black"))
                        .scrollContentBackground(.hidden)
                    }
                    
                }
            }.frame(maxHeight: .infinity,alignment: .top).padding(.top)
            
        }.task {
            controller.getCharacterDetail(id: self.character.id)
            controller.getEpisodes(for: self.stringEpisodes)
            self.characterDetail = controller.character
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
