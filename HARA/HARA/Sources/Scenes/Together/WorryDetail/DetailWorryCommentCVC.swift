//
//  DetailWorryCommentCVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/11.
//

import UIKit
import SnapKit
import Then

class DetailWorryCommentCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let profileImageButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "together_profile_icon"), for: .normal)
    }
    
    private let userName = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = .hGray1
        $0.font = .haraSub3R12
    }
    
    private let createdAt = UILabel().then {
        $0.font = .haraSub3R12
        $0.textColor = .hGray2
        $0.text = "2022.12.25"
    }
    
    private let commentContent = UILabel().then {
        $0.font = .haraB2M14
        $0.textColor = .hGray1
        $0.text = "우와 어쩌고 저쩌고 휴휴,,하,,,하,,우와아앙,,배고파!"
    }
    
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension DetailWorryCommentCVC {
    private func setLayout() {
        self.addSubviews([profileImageButton, userName, createdAt, commentContent])
        
        profileImageButton.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        userName.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(profileImageButton.snp.trailing).offset(6)
            $0.height.equalTo(14)
        }
        
        createdAt.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(userName.snp.trailing).offset(6)
            $0.height.equalTo(userName)
        }
        
        commentContent.snp.makeConstraints {
            $0.top.equalTo(userName.snp.bottom)
            $0.leading.equalTo(profileImageButton.snp.trailing).offset(6)
            $0.height.equalTo(22)
        }
    }
}
