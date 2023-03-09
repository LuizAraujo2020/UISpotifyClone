//
//  Song.swift
//  UISpotifyClone
//
//  Created by Luiz Araujo on 09/03/23.
//

import Foundation

struct Song: Identifiable {
    var id: String { title }
    let title: String
    let artist: String
    let coverString: String
    var explicit = false

    static func getSongs(titles: [String] = songsSamples) -> [Song] {
        var result = [Song]()

        for title in titles {
            let song = Song(title: title, artist: "Breaking Benjamin", coverString: "cover")
            result.append(song)
        }

        return result
    }
}

let songsSamples = ["Breath", "Had Enough", "Here We Are", "You Fight Me", "Intro", "Topless", "Unknown Soldier", "Outro", "The Diary of Jane (single version)", "You", "Until The End", "Dance with the Devil", "Evil Angel"]
