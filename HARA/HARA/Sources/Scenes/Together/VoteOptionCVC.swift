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
    }
    
    private let optionLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraB3R14
        $0.text = "선택지 글자수 제한은 공백 포함 20"
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .hBlue1
                optionLabel.textColor = .hWhite
                contentView.layer.borderWidth = 0
            } else {
                contentView.backgroundColor = .hWhite
                contentView.layer.borderColor = UIColor.hBlue2.cgColor
                contentView.layer.borderWidth = 1
                optionLabel.textColor = .hBlue2
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
    
    //TODO: cell 클릭시 다른 셀 클릭해제
    // MARK: - Function
    func setData(isSelected: Bool) {
        optionLabel.textColor = isSelected ? .hBlue1 : .hBlack
        checkButton.isSelected = isSelected
        contentView.backgroundColor = isSelected ? .hBlue1 : .hGray4
    }
    
    // MARK: - UI
    private func setUI() {
        contentView.backgroundColor = .hWhite
        contentView.layer.borderColor = UIColor.hBlue2.cgColor
        contentView.layer.borderWidth = 1
        optionLabel.textColor = .hBlue2
        contentView.makeRounded(cornerRadius: 8)
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