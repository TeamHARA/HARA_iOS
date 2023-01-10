//
//  DetailWorryCardVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/08.
//

import UIKit
import SnapKit
import Then

final class DetailWorryCardVC: UIViewController {
    
    // MARK: - Properties
    private let closeDetailButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "detailWorry_close_icon"), for: .normal)
    }
    
    private let worryStateTitle = UILabel().then {
        $0.font = .haraH1Sb16
        $0.textColor = .hGray1
        $0.text = "고민중"
    }
    
    private let profileImageButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "together_profile_icon"), for: .normal)
    }
    
    private let userName = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = .hGray2
        $0.font = .haraSub1Sb12
    }
    
    private let createdAt = UILabel().then {
        $0.font = .haraSub3R12
        $0.textColor = .hGray2
        $0.text = "2022.12.25"
    }
    
    private let categoryTitle = UILabel().then {
        $0.font = .haraSub2M12
        $0.textColor = .hBlue1
        $0.text = "진로고민"
    }
    
    private let worryTitle = UILabel().then {
        $0.font = .haraH1Sb16
        $0.textColor = .hGray1
        $0.text = "글자수 제한은 공백 포함 28자 글자수 제한은 공백"
        $0.numberOfLines = 0
    }
    
    private let worryContent = UILabel().then {
        $0.font = .haraB3R14
        $0.textColor = .hGray1
        $0.text = "아니 제가 어쩌고 저쩌고 해서 저쩌고 한데 저쩌고하거든요 그래서 진짜로 어쩌고 저쩌고 해요 강아지 멍멍 고양이 야옹야옹후하후하후하"
        $0.numberOfLines = 0
    }
    
    private lazy var voteOptionCV: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
        view.backgroundColor = .yellow
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        return view
    }()
    
    private var optionNums = 3
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let fracHeight = CGFloat(Double(1) / Double(self.optionNums))
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(126.adjustedH))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(10), trailing: nil, bottom: .fixed(10))
        //        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(fracHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        //            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            group.interItemSpacing = .flexible(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 50
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    private var voteButton = UIButton().then {
        $0.setTitle("투표하기", for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.setTitleColor(.hOrange1, for: .normal)
        $0.isEnabled = false
        $0.setBackgroundColor(.hWhite, for: .disabled)
        $0.setBackgroundColor(.hOrange3, for: .normal)
        $0.makeRounded(cornerRadius: 8)
        $0.layer.borderColor = UIColor.hOrange2.cgColor
        $0.layer.borderWidth = 1
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setLayout()
        setPressAction()
        setVoteOptionCV()
    }
    
    // MARK: - Function
    private func setVoteOptionCV() {
        voteOptionCV.dataSource = self
        voteOptionCV.delegate = self
        
        voteOptionCV.register(cell: DetailWorryCVC.self, forCellWithReuseIdentifier: DetailWorryCVC.className)
    }

    private func setPressAction() {
        self.closeDetailButton.press {
            self.dismiss(animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension DetailWorryCardVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return optionNums
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWorryCVC.className, for: indexPath) as! DetailWorryCVC
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width
//        return CGSize(width: width, height: 200.adjustedH)
//    }
    
}

// MARK: - UICollectionViewDelegate
extension DetailWorryCardVC: UICollectionViewDelegate {
}

// MARK: - Layout
extension DetailWorryCardVC {
    private func setLayout() {
        view.addSubviews([closeDetailButton, worryStateTitle, profileImageButton,userName, createdAt, categoryTitle, worryTitle, worryContent, voteOptionCV, voteButton])
        
        closeDetailButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(13)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(24)
        }
        
        worryStateTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(19)
        }
        
        profileImageButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(66)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(34)
        }
        
        userName.snp.makeConstraints {
            $0.leading.equalTo(profileImageButton.snp.trailing).offset(6)
            $0.top.equalTo(profileImageButton)
        }
        
        createdAt.snp.makeConstraints {
            $0.leading.equalTo(userName)
            $0.bottom.equalTo(profileImageButton)
        }
        
        categoryTitle.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(22)
            $0.bottom.equalTo(profileImageButton)
        }
        
        worryTitle.snp.makeConstraints {
            $0.top.equalTo(profileImageButton.snp.bottom).offset(17)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        worryContent.snp.makeConstraints {
            $0.top.equalTo(worryTitle.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        voteOptionCV.snp.makeConstraints {
            $0.top.equalTo(worryContent.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(262)
        }
        
        voteButton.snp.makeConstraints {
            $0.top.equalTo(voteOptionCV.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(voteOptionCV)
            $0.height.equalTo(44.adjustedH)
        }
    }
}
