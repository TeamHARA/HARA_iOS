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
        $0.backgroundColor = .systemCyan
        $0.distribution = .fillProportionally
        $0.axis = .vertical
    }
    //TODO: 보더 안먹힘
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
    }
    
    private let advantageLabel = UILabel().then{
        $0.numberOfLines = 1
        let advantage = NSAttributedString(string: "장점 ", attributes: [
            .font: UIFont.haraB2M14, .foregroundColor: UIColor.hBlue1])
        let advantageContent = NSAttributedString(string: "이거는 장점입니다. ", attributes: [
            .font: UIFont.haraB2M14, .foregroundColor: UIColor.hGray1])
        let content = advantage + advantageContent
        $0.attributedText = content
    }
    
    private let disadvantageLabel = UILabel().then{
        $0.numberOfLines = 1
        let disadvantage = NSAttributedString(string: "단점 ", attributes: [
            .font: UIFont.haraB2M14, .foregroundColor: UIColor.hRed])
        let disadvantageContent = NSAttributedString(string: "이거는 단점dfgfdgfdgdfgfdgdfgfdgdfgfdgdfgdfgfdgfdgfdgdfgdfgfdgfdgdfg입니다. ", attributes: [
            .font: UIFont.haraB2M14, .foregroundColor: UIColor.hGray1])
        let content = disadvantage + disadvantageContent
        $0.attributedText = content
    }
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        //임시 배경색 설정
        self.contentView.backgroundColor = .blue
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setUI() {
        contentView.makeRounded(cornerRadius: 8)
        contentView.backgroundColor = .orange
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
            
        }
    }
}
