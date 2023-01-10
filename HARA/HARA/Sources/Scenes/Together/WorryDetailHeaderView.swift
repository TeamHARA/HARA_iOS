//
//  WorryDetailHeaderView.swift
//  HARA
//
//  Created by 김담인 on 2023/01/10.
//

import UIKit
import SnapKit
import Then

final class WorryDetailHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
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
        $0.text = "글자수 제한 "
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension WorryDetailHeaderView {
    private func setLayout() {
        self.addSubviews([profileImageButton, userName, createdAt,categoryTitle,  worryTitle, worryContent])
        
        profileImageButton.snp.makeConstraints {
            $0.top.equalToSuperview()
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
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}

