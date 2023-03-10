//
//  DetailWorryCVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/09.
//

import UIKit
import SnapKit
import Then

final class DetailWorryCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let optionDetailStackView = UIStackView().then {
        $0.spacing = 6
        $0.distribution = .fillProportionally
        $0.axis = .vertical
    }
    private let voteOptionView = UIView().then {
        $0.layer.borderColor = UIColor.hGray4.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
    }
    
    private let checkButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named:"together_checked_icon"), for: .selected)
        $0.setBackgroundImage(UIImage(named:"together_unChecked_icon"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    private let optionLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraB3R14
        $0.text = "청춘은 얼마나 영락과 주며, 말이다."
        $0.sizeToFit()
        $0.numberOfLines = 1
    }
    
    private let advantageLabel = UILabel().then{
        $0.numberOfLines = 0
        let advantage = NSAttributedString(string: "장점  ", attributes: [
            .font: UIFont.haraB2M14, .foregroundColor: UIColor.hBlue1])
        let advantageContent = NSAttributedString(string: "글자수 제한 공백 포함 50자, 두줄이 최대라고 판단했습니다요..흑흑 글자수 제한 공백 포", attributes: [
            .font: UIFont.haraB2M14, .foregroundColor: UIColor.hGray1])
        let content = advantage + advantageContent
        $0.attributedText = content
    }
    
    private let disadvantageLabel = UILabel().then{
        $0.numberOfLines = 0
        let disadvantage = NSAttributedString(string: "단점  ", attributes: [
            .font: UIFont.haraB2M14, .foregroundColor: UIColor.hRed])
        let disadvantageContent = NSAttributedString(string: "글자수 ", attributes: [
            .font: UIFont.haraB2M14, .foregroundColor: UIColor.hGray1])
        let content = disadvantage + disadvantageContent
        $0.attributedText = content
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
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setUI() {
        contentView.makeRounded(cornerRadius: 8)
        contentView.layer.borderColor = UIColor.hGray4.cgColor
        contentView.layer.borderWidth = 1
    }

}

// MARK: - Layout
extension DetailWorryCVC {
    private func setLayout() {
        
        contentView.addSubviews([voteOptionView, optionDetailStackView])

        voteOptionView.addSubviews([checkButton, optionLabel])
        
        optionDetailStackView.addArrangedSubviews([advantageLabel, disadvantageLabel])
        
        voteOptionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(12)
            $0.top.equalToSuperview().offset(12)
            $0.height.equalTo(40.adjustedH)
        }
        
        checkButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.top.equalToSuperview().offset(9)
            $0.width.equalTo(18.adjustedW)
            $0.height.equalTo(18.adjustedH)
        }
        
        optionLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(6)
            $0.top.equalToSuperview().inset(9)
        }
        
        optionDetailStackView.snp.makeConstraints {
            $0.top.equalTo(voteOptionView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().inset(17)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
