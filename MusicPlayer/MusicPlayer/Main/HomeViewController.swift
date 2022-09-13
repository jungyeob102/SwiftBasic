//
//  ViewController.swift
//  MusicPlayer
//
//  Created by 이중엽 on 2022/09/11.
//

import UIKit

class HomeViewController: UIViewController {

    let trackManager: TrackManager = TrackManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension HomeViewController: UICollectionViewDataSource {
    //지정된 섹션에 표시할 항목의 개수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackManager.tracks.count
    }
    
    //컬렉션뷰의 지정된 위치에 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackColletionViewCell", for: indexPath) as? TrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let track: Track? = trackManager.track(at: indexPath.item)
        cell.updateUI(item: track)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //헤더뷰 객체에 아이템이 없는 경우 UICollectionReusableView를 반환하면 되지만, UICollectionView크기가 고정값을 가지고 있으면, 직접 header를 반환해야한다. 그렇지 않으면 오류를 뱉음
        
//        if kind == UICollectionView.elementKindSectionHeader {
//            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else {
//                return UICollectionReusableView()
//            }
//            return header
//        }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let item = trackManager.todayMusic else {
                return UICollectionReusableView()
            }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else {
                return UICollectionReusableView()
            }
            
            header.update(with: item)
            header.tapHandler = { item -> Void in
                print("\(item.convertToTrack()?.title)")
            }
            return header
            
        default:
            return UICollectionReusableView()
        }
        
        
        return UICollectionReusableView()
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    //지정된 셀이 선택되었음을 알리는 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("곡선택")
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
//    셀 사이즈 지정 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing: CGFloat = 20
        let margin: CGFloat = 20
        let width: CGFloat = (collectionView.bounds.width - itemSpacing - margin * 2)/2
        let height: CGFloat = width + 60
        return CGSize(width: width, height: height)
    }
}
