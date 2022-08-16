//
//  ViewController.swift
//  Test
//
//  Created by 이중엽 on 2022/08/10.
//

import UIKit

class TodoListViewController: UIViewController {
    
    //MARK: 변수 선언
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: 앱 첫 실행 함수
    //앱을 화면에 들어오면 처음 실행시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: 메서드 선언
    
}

extension TodoListViewController: UICollectionViewDataSource{
    
    //섹션 별 아이템이 몇개를 사용할지 결정 (UICollectionViewDataSource 프로토콜)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    //헤더뷰
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodoListHeaderView", for: indexPath) as? TodoListHeaderView else{
                return UICollectionReusableView()
            }
            
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
}

class TodoListHeaderView: UICollectionReusableView {
    
}
