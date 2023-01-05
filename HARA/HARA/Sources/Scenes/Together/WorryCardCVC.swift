//
//  WorryCardCVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/05.
//

import UIKit
import SnapKit
import Then

class WorryCardCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let worryCategoryLabel = UILabel().then {
        $0.textColor = .hBlue1
        $0.font = .haraSub1Sb12
        $0.text = "패션,뷰티"
    }
    
    private let worryDateLabel = UILabel().then {
        $0.textColor = .hBlue2
        $0.font = .haraSub3R12
        $0.text = "2022.12.25"
    }
    
    private let worryTitleLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraH1Sb16
        $0.text = "글자수 제한은 공백 포함 28자 글자수 제한은 공백"
    }
    
    private let worryContentLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraB2M14
        $0.text = "1. 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려 강산 대한 사람 대한으로 길이 보전하세 2. 남산 위에 저 소나무 철갑을 두른 듯 바람 서리 불변함은 우리 기상일세 무궁화 삼천리 화려 강산 대한 사람 대한으로 길이 보전하세 3. 가을 하늘 공활한데 ..."
        $0.numberOfLines = 0
    }
    
    private let voteOptionCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.isScrollEnabled = false
        $0.backgroundColor = .yellow
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets.zero
    }
    
    private let voteButton = UIButton().then {
        $0.setTitle("투표하기", for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.setTitleColor(.hOrange1, for: .normal)
        $0.setBackgroundColor(.hWhite, for: .normal)
        $0.setBackgroundColor(.hOrange3, for: .selected)
        $0.makeRounded(cornerRadius: 8)
        $0.layer.borderColor = UIColor.hOrange2.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let chatButton = UIButton().then {
        $0.setImage(UIImage(named: "together_chat_icon"), for: .normal)
        var config = UIButton.Configuration.plain()
        config.imagePadding = 5
        $0.configuration = config
        let attribute = [NSAttributedString.Key.font: UIFont.haraSub3R12, NSAttributedString.Key.foregroundColor: UIColor.hGray3 ]
        let attributedTitle = NSAttributedString(string: "10", attributes: attribute)
        $0.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setvoteOptionCV()
        setLayout()
        setPressAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    // MARK: - Function
    private func setPressAction() {
        voteButton.press {
            self.voteButton.backgroundColor = .black
        }
    }
    
    private func setvoteOptionCV() {
        voteOptionCV.dataSource = self
        voteOptionCV.delegate = self
        
        voteOptionCV.register(cell: VoteOptionCVC.self, forCellWithReuseIdentifier: VoteOptionCVC.className)
    }

    
    // MARK: - Layout
    private func setLayout() {
        contentView.addSubviews([worryCategoryLabel, worryDateLabel, worryTitleLabel, worryContentLabel,voteOptionCV,voteButton, chatButton])
        
        worryCategoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.top.equalToSuperview().offset(16)
        }
        
        worryDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(14)
        }
        
        worryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(worryCategoryLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().inset(14)
        }

        worryContentLabel.snp.makeConstraints {
            $0.top.equalTo(worryTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().inset(14)
//            $0.height.equalTo(110.adjustedH)
        }
        
        voteOptionCV.snp.makeConstraints {
            $0.top.equalTo(worryContentLabel.snp.bottom).offset(10)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        voteButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(52)
            $0.height.equalTo(40.adjustedH)
        }

        chatButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(16)
//            $0.width.equalTo(39.adjustedW)
//            $0.height.equalTo(24.adjustedH)
        }
        
        
        
    }
}

// MARK: - UICollectionViewDataSource
extension WorryCardCVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Todo: Cell만들기
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteOptionCVC.className, for: indexPath) as! VoteOptionCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 312.adjustedW, height: 40.adjustedH)
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WorryCardCVC: UICollectionViewDelegateFlowLayout {

}



