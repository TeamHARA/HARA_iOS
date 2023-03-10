//
//  voteOptionCVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/04.
//

import UIKit
import SnapKit
import Then

class VoteOptionCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let checkButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named:"together_checked_icon"), for: .selected)
        $0.setBackgroundImage(UIImage(named:"together_unChecked_icon"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    private let optionLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraB3R14
        $0.text = "선택지 글자수 제한은 공백 포함 20"
    }
    
    private var alreadySelected = false
        
    override var isSelected: Bool {
        didSet {
            if isSelected {
                /// 셀을 클릭할 때 cell 의 isSelect가 바로 true로 되기 때문에 alreadySlected를 통해 이미 선택된 상태면 isSelect를 false로 바꿈
                if alreadySelected {
                    alreadySelected = false
                    isSelected = false
                }else {
                    optionLabel.textColor = .hBlue1
                    contentView.layer.borderColor = UIColor.hBlue2.cgColor
                    contentView.layer.borderWidth = 1
                    self.checkButton.isSelected = true
                    alreadySelected = true
                }
            } else {
                optionLabel.textColor = .hBlack
                contentView.backgroundColor = .hWhite
                contentView.layer.borderColor = UIColor.hGray4.cgColor
                contentView.layer.borderWidth = 1
                self.checkButton.isSelected = false
            }
        }
    }
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setUI() {
        contentView.makeRounded(cornerRadius: 8)
        contentView.backgroundColor = .hWhite
        contentView.layer.borderColor = UIColor.hGray4.cgColor
        contentView.layer.borderWidth = 1
        optionLabel.textColor = .hBlack
    }
    
    // MARK: - Layout
    private func setLayout() {
        contentView.addSubviews([checkButton, optionLabel])
        
        checkButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.top.equalToSuperview().offset(9)
            $0.width.equalTo(18.adjustedW)
            $0.height.equalTo(18.adjustedH)
        }
        
        optionLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(6)
            $0.top.equalToSuperview().offset(9)
        }
    }
}


