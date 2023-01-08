//
//  TogetherWorriedCVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/07.
//


import UIKit
import SnapKit
import Moya
import Then

class TogetherWorriedCVC: UICollectionViewCell {
    
    // MARK: - Properties 변수 선언
    static let identifier2 = "TogetherWorriedCVC"
    
    //private let aloneContainerView = UIView()
    private let worringIcon = UIImageView()
    private let titleLabel = UILabel().then {
        $0.textColor = .hBlue1
        $0.font = .haraB2M14
    }
    private let mainLabel = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraB3R14
    }
    private let date = UILabel().then {
        $0.textColor = .hGray2
        $0.font = .haraSub2M12
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setCellUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Layout
extension TogetherWorriedCVC {
    private func setCellUI() {
        self.contentView.layer.borderColor = UIColor.hBlue2.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.sizeToFit()
        self.contentView.layer.cornerRadius = 10
        self.contentView.backgroundColor = .hWhite
    }
    private func layout() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        [worringIcon, titleLabel, mainLabel, date].forEach{
            contentView.addSubview($0)
        }
        worringIcon.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(2.adjustedW).inset(13)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(7.adjustedH)
            $0.leading.equalTo(10.adjustedH).inset(73)
            $0.bottom.equalToSuperview().inset(52)
            $0.height.equalTo(60.adjustedH)
        }
        mainLabel.snp.makeConstraints{
            $0.top.equalTo(40.adjustedH)
            $0.leading.equalTo(2.adjustedH).inset(18)
        }
        date.snp.makeConstraints{
            $0.top.equalTo(65.adjustedH)
            $0.trailing.equalTo(2.adjustedW).inset(10)
        }
    }
    func dataBind(model: TogetherWorriedModel){
        worringIcon.image = UIImage(named: model.worring)
        titleLabel.text = model.categoryTitle
        mainLabel.text = model.mainText
        date.text = model.date
    }
}
