//
//  TrackCollectionViewCell.swift
//  MusicPlayer
//
//  Created by 이중엽 on 2022/09/11.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trackThumbnail: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackArtist: UILabel!
    
    //UICollectionViewCell이 화면에 등장할 때 호출되는 메서드
    override func awakeFromNib() {
        super.awakeFromNib()
        trackThumbnail.layer.cornerRadius = 4
        trackArtist.textColor = UIColor.systemGray2
    }
    
    func updateUI(item: Track?) {
        guard let track = item else { return }
        self.trackThumbnail.image = track.artwork
        self.trackTitle.text = track.title
        self.trackArtist.text = track.artist
    }
}
