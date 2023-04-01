//
//  EpisodeDetailView.swift
//  RickMorty
//
//  Created by Santino Fajardo on 31/03/2023.
//

import SwiftUI

struct EpisodeDetailView: View {
    
    @State private var episode: Episodes
    @State private var season: String
    @State private var episodeNumber: String
    init(episode: Episodes) {
        self._episode = State(initialValue: episode)
           
           self._season = State(initialValue: String(episode.episode.prefix(3)))
           self._episodeNumber = State(initialValue: String(episode.episode.suffix(3)))
    }
    
    
    
    var body: some View {
        ZStack {
            Color("Black").ignoresSafeArea()
            Image("BackgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.3)

            VStack{
                    Text(episode.name).foregroundColor(.white).bold().font(.title)
                    Text("Season: \(season)").foregroundColor(.white)
                    Text("Episode: \(episodeNumber)").foregroundColor(.white)
                }
        }
        
    }
}

struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
