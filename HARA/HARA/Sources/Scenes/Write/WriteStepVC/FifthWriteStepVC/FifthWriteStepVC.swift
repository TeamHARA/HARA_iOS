//
//  FifthStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

class FifthWriteStepVC: UIViewController{
    
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
        let normalString1 = NSAttributedString(string: "그렇다면 이 고민 ", attributes: [
            .font: UIFont.haraM1M24])
        let boldString = NSAttributedString(string: "어떻게\n", attributes: [
            .font: UIFont.haraM1B24])
        let normalString2 = NSAttributedString(string: "해결해볼까요?", attributes: [
            .font: UIFont.haraM1M24])
        
        let title = normalString1 + boldString + normalString2
        $0.attributedText = title
        $0.textAlignment = .center
    }
    
    /// NSAttributedString으로 넘겨줘야 여러줄인 제목의 폰트 및 크기를 서로 다르게 설정해줄 수 있다.
    var aloneLabel: NSAttributedString = {
        let title = NSAttributedString(string: "\n혼자 고민할래요\n\n\n", attributes: [
            .font: UIFont.haraH2M16])
        let detail = NSAttributedString(string: "투표창 없이\n혼자 선택할 수 있어요", attributes: [
            .font: UIFont.haraSub3R12])
        let buttonlabel = title + detail
        return buttonlabel
    }()
    
    /// NSAttributedString으로 넘겨줘야 여러줄인 제목의 폰트 및 크기를 서로 다르게 설정해줄 수 있다.
    var everyoneLabel: NSAttributedString = {
        let title = NSAttributedString(string: "\n함께 고민할래요\n\n\n", attributes: [
            .font: UIFont.haraH2M16])
        let detail = NSAttributedString(string: "투표로 다른 사람들의\n의견도 들어볼 수 있어요", attributes: [.font: UIFont.haraSub3R12])
        let buttonlabel = title + detail
        return buttonlabel
    }()
    
    private let divisionLine = UILabel().then{
        $0.backgroundColor = .hBlue3
    }
    
    /// NSLineBreakMode.byWordWrapping을 통해 Enter로 분류된 제목을 맞게 표현 가능하다.
    lazy var aloneButton = UIButton().then{
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.hGray4.cgColor
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .hWhite
        $0.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        $0.titleLabel?.textAlignment = .center
        $0.setAttributedTitle(aloneLabel, for: .normal)
        $0.setTitleColor(.hGray4, for: .normal)
        $0.titleLabel?.font = .haraH2M16
    }
    
    lazy var everyoneButton = UIButton().then{
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.hGray4.cgColor
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .hWhite
        $0.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        $0.titleLabel?.textAlignment = .center
        $0.setAttributedTitle(everyoneLabel, for: .normal)
        $0.setTitleColor(.hGray4, for: .normal)
        $0.titleLabel?.font = .haraH2M16
    }
    
    var delegate: SendIsclickedDelegate?
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .hGray5
        setLayout()
        setPress()
    }
    
    // MARK: - Functions
    private func setPress(){
        /// '혼자 고민할래요' 버튼을 눌렀을 경우
        aloneButton.press {
            /// '혼자 고민할래요' 버튼 활성화
            self.aloneButton.isSelected = true
            self.aloneButton.layer.borderColor = UIColor.hBlue1.cgColor
            self.aloneButton.setTitleColor(.hBlue1, for: .normal)
            /// '함께 고민할래요' 버튼을 비활성화 시키고, isSelected를 false로 처리
            self.everyoneButton.isSelected = false
            self.everyoneButton.layer.borderColor = UIColor.hGray4.cgColor
            self.everyoneButton.setTitleColor(.hGray4, for: .normal)
            self.delegate?.SendIsclicked(alone: self.aloneButton.isSelected, everyone: self.everyoneButton.isSelected)
        }
        everyoneButton.press {
            /// '함께 고민할래요' 버튼 활성화
            self.everyoneButton.isSelected = true
            self.everyoneButton.layer.borderColor = UIColor.hBlue1.cgColor
            self.everyoneButton.setTitleColor(.hBlue1, for: .normal)
            /// '혼자 고민할래요' 버튼을 비활성화 시키고, isSelected를 false로 처리
            self.aloneButton.isSelected = false
            self.aloneButton.layer.borderColor = UIColor.hGray4.cgColor
            self.aloneButton.setTitleColor(.hGray4, for: .normal)
            self.delegate?.SendIsclicked(alone: self.aloneButton.isSelected, everyone: self.everyoneButton.isSelected)
        }
    }
}

// MARK: - Layout
extension FifthWriteStepVC{
    private func setLayout(){
        view.addSubViews([background, navigationView, progressView, questionLabel,
                          aloneButton, everyoneButton])
        
        background.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(4.adjustedH)
            $0.width.equalTo((UIScreen.main.bounds.size.width))
        }
        
        progressView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(4.adjustedH)
            $0.width.equalTo(UIScreen.main.bounds.size.width)
        }
        
        questionLabel.snp.makeConstraints{
            $0.top.equalTo(navigationView.snp.bottom).offset(70.adjustedH)
            $0.leading.equalToSuperview().offset(73.adjustedW)
            $0.trailing.equalToSuperview().offset(-73.adjustedW)
        }
        
        aloneButton.snp.makeConstraints{
            $0.top.equalTo(questionLabel.snp.bottom).offset(82.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.width.equalTo(162.adjustedW)
            $0.height.equalTo(184.adjustedH)
        }
        
        everyoneButton.snp.makeConstraints{
            $0.top.equalTo(aloneButton)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.width.equalTo(162.adjustedW)
            $0.height.equalTo(184.adjustedH)
        }
    }
}

// MARK: - Protocols
protocol SendIsclickedDelegate{
    func SendIsclicked(alone: Bool, everyone: Bool)
}

