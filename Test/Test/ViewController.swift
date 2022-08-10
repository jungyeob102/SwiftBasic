//
//  ViewController.swift
//  Test
//
//  Created by 이중엽 on 2022/08/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    var diceArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6")]
    
    //앱을 화면에 들어오면 처음 실행시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func rollButtonTabbed(_ sender: UIButton) {
        //첫번째 이미지뷰의 이미지를 랜덤으로 변경
        firstImageView.image = diceArray.randomElement()
        
        //두번째 이미지뷰의 이미지를 랜덤으로 변경
        secondImageView.image = diceArray.randomElement()
    }
    
    
}
