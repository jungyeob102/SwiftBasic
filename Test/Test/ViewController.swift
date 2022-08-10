//
//  ViewController.swift
//  Test
//
//  Created by 이중엽 on 2022/08/10.
//

import UIKit

class ViewController: UIViewController {

    //MARK: 속성 선언
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var comImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var comChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    var rpsImageArray: [UIImage] = [#imageLiteral(resourceName: "rock"), #imageLiteral(resourceName: "scissors"), #imageLiteral(resourceName: "paper")]
    
    var comChoice: Rps = Rps(rawValue: Int.random(in: 0...2))!
    var myChoice: Rps = Rps.rock
    
    //MARK: 앱 첫 실행 함수
    //앱을 화면에 들어오면 처음 실행시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1) 첫번째/두번째 이미지뷰에 준비 이미지를 띄워야 함
        comImageView.image = UIImage(named: "ready.png")
        myImageView.image = UIImage(named: "ready.png")
        //2) 첫번째/두번째 레이블에 "준비" 문자열을 띄워야 함
        
        comChoiceLabel.text = "준비"
        myChoiceLabel.text = "준비"
    }

    //MARK: 메서드 선언
    @IBAction func rpsButtonTabbed(_ sender: UIButton) {
        //가위/ 바위/ 보를 선택해서 데이터 저장
        //guard let title = sender.currentTitle else { return }
        
        let title = sender.currentTitle!
        
        switch title {
        case "가위":
            myChoice = .scissors
        case "바위":
            myChoice = .rock
        case "보":
            myChoice = .paper
        default:
            break
        }
    }
    
    @IBAction func selectButtonTabbed(_ sender: UIButton) {
        comChoice = Rps(rawValue: Int.random(in: 0...2))!
        // 1) 컴퓨터가 랜덤으로 선택한 이미지를 이미지뷰에 표시
        // 2) 컴퓨터가 랜덤으로 선택한 이미지를 레이블에 표시
        switch comChoice {
        case .rock:
            comImageView.image = UIImage(named: "rock.png")
            comChoiceLabel.text = "바위"
        case .scissors:
            comImageView.image = UIImage(named: "scissors.png")
            comChoiceLabel.text = "가위"
        case .paper:
            comImageView.image = UIImage(named: "paper.png")
            comChoiceLabel.text = "보"
        }
        
        // 3) 내가 랜덤으로 선택한 이미지를 이미지뷰에 표시
        // 4) 내가 랜덤으로 선택한 이미지를 레이블에 표시
        switch myChoice {
        case .rock:
            myImageView.image = UIImage(named: "rock.png")
            myChoiceLabel.text = "바위"
        case .scissors:
            myImageView.image = UIImage(named: "scissors.png")
            myChoiceLabel.text = "가위"
        case .paper:
            myImageView.image = UIImage(named: "paper.png")
            myChoiceLabel.text = "보"
        }
        
        
        // 5) 컴퓨터가 선택한 정보와 비교하여 승패판단 후 표시
        if comChoice == myChoice {
            mainLabel.text = "비겼다!"
        }
        else if comChoice == .rock && myChoice == .paper {
            mainLabel.text = "이겼다!"
        }
        else if comChoice == .paper && myChoice == .scissors {
            mainLabel.text = "이겼다!"
        }
        else if comChoice == .scissors && myChoice == .rock {
            mainLabel.text = "이겼다!"
        }
        else {
            mainLabel.text = "졌다..."
        }
    }
    
    
    @IBAction func resetButtonTabbed(_ sender: UIButton) {
        //1) 첫번째/두번째 이미지뷰에 준비 이미지를 띄워야 함
        comImageView.image = UIImage(named: "ready.png")
        myImageView.image = UIImage(named: "ready.png")
        //2) 첫번째/두번째 레이블에 "준비" 문자열을 띄워야 함
        
        comChoiceLabel.text = "준비"
        myChoiceLabel.text = "준비"
        
        mainLabel.text = "선택하세요"
    }
    
}
