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
        
    override var isSelected: Bool {
        didSet {
            if isSelected {
//                contentView.backgroundColor = .hBlue1
                optionLabel.textColor = .hBlue1
                contentView.layer.borderColor = UIColor.hBlue2.cgColor
                contentView.layer.borderWidth = 1
                self.checkButton.isSelected = true
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
//        setPressAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
//    func setPressAction() {
//        self.checkButton.press {
//            if self.isSelected == true{
//                self.isSelected = false
//            }else {
//                self.isSelected = true
//            }
//
//        }
//    }
    
    func setData(isSelected: Bool) {
        optionLabel.textColor = isSelected ? .hBlue1 : .hBlack
        checkButton.isSelected = isSelected
//        contentView.backgroundColor = isSelected ? .hBlue1 : .hGray4
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


