//
//  TrackManager.swift
//  MusicPlayer
//
//  Created by 이중엽 on 2022/09/13.
//

import UIKit
import AVFoundation

class TrackManager {
    //TODO: 트랙 프로퍼티 정의하기
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todayMusic: AVPlayerItem?
    
    
    
    //TODO: 트랙 생성자 구현하기
    init() {
//        print("트랙 매니저 생성")
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todayMusic = self.tracks.randomElement()
    }
    
    //TODO: 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
//        print("트랙 로드")
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        
        let items = urls.map { AVPlayerItem(url: $0) }
        
        return items
    }
    
    //TODO: 인덱스에 맞는 트랙 로드하기
    func track(at index: Int) -> Track? {
//        print("인덱스에 맞는 트랙 로드")
        let playerItem: AVPlayerItem = tracks[index]
        let track: Track? = playerItem.convertToTrack()
        
        return track
    }
    
    //TODO: 앨범 로딩 메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
//        print("앨범 로딩")
        //convertToTrack의 return값이 nil이 될 수도 있기 때문에 compactMap을 사용해준다.
        let trackList: [Track] = tracks.compactMap { $0.convertToTrack() }
        let albumDics = Dictionary(grouping: trackList) { $0.albumName }
        
        var albums: [Album] = []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        return albums
    }
    
    func loadOtherTodaysTrack() {
        self.todayMusic = self.tracks.randomElement()
    }
}
