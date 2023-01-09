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
        $0.text = "1. 동해물과 백두산이 마"
        $0.numberOfLines = 0
    }
    
    private lazy var voteOptionCV: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
        view.isScrollEnabled = false
        view.backgroundColor = .yellow
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(10), trailing: nil, bottom: .fixed(10))
//        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
//            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
//            group.interItemSpacing = .flexible(-16)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
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
        config.imagePadding = 2
        config.contentInsets = NSDirectionalEdgeInsets.zero
        $0.configuration = config
        
        let attribute = [NSAttributedString.Key.font: UIFont.haraSub3R12, NSAttributedString.Key.foregroundColor: UIColor.hGray3 ]
        let attributedTitle = NSAttributedString(string: "10", attributes: attribute)
        $0.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    private var optionNums = 2

    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setVoteOptionCV()
        setLayout()
        setPressAction()
        self.contentView.backgroundColor = .green
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
    
    private func setVoteOptionCV() {
        voteOptionCV.dataSource = self
        voteOptionCV.delegate = self
        
        voteOptionCV.register(cell: VoteOptionCVC.self, forCellWithReuseIdentifier: VoteOptionCVC.className)
    }
    
    func setCellNums(optionNums: Int) {
        self.optionNums = optionNums
    }
        
    func setData(title: String, content: String) {
        self.worryTitleLabel.text = title
        self.worryContentLabel.text = content
        self.worryContentLabel.sizeToFit()
    }
}

// MARK: - UICollectionViewDataSource
extension WorryCardCVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(optionNums)
        return optionNums
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Todo: Cell만들기
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteOptionCVC.className, for: indexPath) as! VoteOptionCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 40.adjustedH)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WorryCardCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - Layout
extension WorryCardCVC {
    private func setLayout() {
        contentView.addSubviews([worryCategoryLabel, worryDateLabel, worryTitleLabel, worryContentLabel,voteOptionCV,voteButton, chatButton])
        
        worryCategoryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.top.equalToSuperview().offset(16)
            $0.height.equalTo(14)
        }
        
        worryDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(14)
            $0.height.equalTo(14)
        }
        
        worryTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().inset(14)
            $0.height.equalTo(19.adjustedH)
        }

        worryContentLabel.snp.makeConstraints {
            $0.top.equalTo(worryTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().inset(14)
//            $0.height.equalTo(66.adjustedH)
        }
        
        voteOptionCV.snp.makeConstraints {
            $0.top.equalTo(worryContentLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(11)
            $0.trailing.equalToSuperview().inset(11)
//            $0.bottom.equalTo(voteButton.snp.top).inset(10)
        }
        
        voteButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(11)
            $0.trailing.equalToSuperview().inset(11)
            $0.bottom.equalToSuperview().inset(52)
            $0.top.equalTo(voteOptionCV.snp.bottom)
            $0.height.equalTo(40.adjustedH)
        }

        chatButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(voteButton.snp.bottom).offset(12)
            $0.width.equalTo(39.adjustedW)
            $0.height.equalTo(24.adjustedH)
        }
    }
}




