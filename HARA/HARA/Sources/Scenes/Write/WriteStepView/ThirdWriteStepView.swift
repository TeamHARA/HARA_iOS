//
//  ThirdStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

class ThirdWriteStepView: UIViewController{
    
    // MARK: - Properties
    private let background = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    lazy var navigationView = UIView().then{
        $0.backgroundColor = .hBlue4
    }
    
    lazy var progressView = UIView().then{
        $0.backgroundColor = .hBlue1
    }
    
    private let questionLabel = UILabel().then{
        $0.numberOfLines = 2
        let NormalString1 = NSAttributedString(string: "선택지의\n", attributes: [
            .font: UIFont.haraM1M24])
        let BoldString = NSAttributedString(string: "장단점", attributes: [
            .font: UIFont.haraM1B24])
        let NormalString2 = NSAttributedString(string: "을 적어보세요.", attributes: [
            .font: UIFont.haraM1M24])
        
        let title = NormalString1 + BoldString + NormalString2
        $0.attributedText = title
    }
    
    private let tipLabel = UILabel().then{
        $0.text = "장단점은 스킵할 수 있어요."
        $0.font = .haraB3R14
        $0.textColor = .hGray2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .hGray3
        setLayout()
    }
}

extension ThirdWriteStepView{
    private func setLayout(){
        view.addSubViews([background, navigationView, progressView, questionLabel, tipLabel])
        
        background.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(4.adjustedH)
            $0.width.equalTo(UIScreen.main.bounds.size.width)
        }
        
        progressView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(4.adjustedH)
            $0.width.equalTo((UIScreen.main.bounds.size.width/4)*3)
        }
        
        questionLabel.snp.makeConstraints{
            $0.top.equalTo(navigationView.snp.bottom).offset(70.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
        }
        
        tipLabel.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(6.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
        }
    }
}
