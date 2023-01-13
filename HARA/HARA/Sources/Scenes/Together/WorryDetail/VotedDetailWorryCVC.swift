//
//  VotedDetailWorryCVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/13.
//

import UIKit
import SnapKit
import Then

final class VotedDetailWorryCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let checkView = UIImageView().then {
        $0.image = UIImage(named: "together_check_icon")
    }
    
    private let optionLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraB3R14
        $0.text = "선택지 글자수 제한은 공백 포함 20"
    }
    
    private let percentageView = UIView().then {
        $0.makeRounded(cornerRadius: 8)
    }
    
    private let percentageValue = UILabel().then {
        $0.font = .haraB2M14
        $0.text = "00%"
    }
    
    private var percentageWidth: CGFloat = 30
    
    
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
    func setPercentage(percentage: CGFloat, isOptionVoted: Bool) {
        self.percentageWidth = self.contentView.frame.width * (percentage/100)
        self.percentageValue.text = "\(percentage)%"
        
        if isOptionVoted {
            optionLabel.textColor = .hBlue1
            contentView.layer.borderColor = UIColor.hBlue2.cgColor
            contentView.layer.borderWidth = 1
            
            percentageView.backgroundColor = .hBlue3
            percentageValue.textColor = .hBlue1
        } else {
            optionLabel.textColor = .hBlack
            contentView.layer.borderColor = UIColor.hGray4.cgColor
            contentView.layer.borderWidth = 1
            
            percentageView.backgroundColor = .hGray2
            percentageValue.textColor = .hGray2
        }
        self.percentageView.snp.updateConstraints {
            $0.width.equalTo(self.percentageWidth)
        }

    }
    
    private func setUI() {
        contentView.makeRounded(cornerRadius: 8)
        contentView.layer.borderColor = UIColor.hGray4.cgColor
        contentView.layer.borderWidth = 1
    }
}

// MARK: - Layout
extension VotedDetailWorryCVC {
    private func setLayout() {
        
        contentView.addSubviews([voteOptionView, optionDetailStackView])

        voteOptionView.addSubviews([percentageView, checkView, percentageValue, optionLabel])
        
        optionDetailStackView.addArrangedSubviews([advantageLabel, disadvantageLabel])
        
        voteOptionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(12)
            $0.top.equalToSuperview().offset(12)
            $0.height.equalTo(40.adjustedH)
        }
        
        checkView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().offset(12)
        }
        
        optionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.leading.equalTo(checkView.snp.trailing).offset(6)
        }
        
        percentageValue.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.trailing.equalToSuperview().inset(14)
        }
        
        percentageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(percentageWidth)
            $0.height.equalToSuperview()
        }
        
        optionDetailStackView.snp.makeConstraints {
            $0.top.equalTo(voteOptionView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().inset(17)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
