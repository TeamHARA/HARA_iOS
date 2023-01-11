//
//  RecentWorriesCVC.swift
//  HARA
//
//  Created by saint on 2023/01/11.
//

import UIKit
import SnapKit
import Then

class RecentWorryCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let optionContainerView = UIView().then{
        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .hWhite
    }
    
    let dateLabel = UILabel().then{
        $0.font = .haraB3R14
        $0.textColor = .hGray2
    }
    
    let worryTitle = UILabel().then{
        $0.font = .haraB2M14
        $0.textColor = .hBlue1
    }
    
    // MARK: - Life Cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecentWorryCVC{
    private func setLayout(){
        backgroundColor = .clear
        contentView.addSubView(optionContainerView)
        optionContainerView.addSubviews([dateLabel, worryTitle])
        
        optionContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(14.adjustedW)
            $0.top.equalToSuperview().offset(10.adjustedH)
        }
        
        worryTitle.snp.makeConstraints{
            $0.leading.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(10.adjustedH)
        }
    }
    
    func dataBind(model: RecentWorryModel) {
        dateLabel.text = model.date
        worryTitle.text = model.worryTitle
    }
}
