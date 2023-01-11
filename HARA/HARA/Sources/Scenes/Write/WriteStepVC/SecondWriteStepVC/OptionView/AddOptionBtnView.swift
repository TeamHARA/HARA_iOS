//
//  AddOptionBtnView.swift
//  HARA
//
//  Created by saint on 2023/01/09.
//

import UIKit
import SnapKit
import Then

class AddOptionBtnView: UIView {
    
    // MARK: - Properties
    private let optionContainerView = UIView().then{
        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .hWhite
    }
    
    let addOptionButton = UIButton().then{
        $0.backgroundColor = .clear
    }
    
    private let addImage = UIImageView().then {
        $0.image = UIImage(named: "addOptionBtn")
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddOptionBtnView{
    private func setLayout(){
        backgroundColor = .clear
        self.addSubView(optionContainerView)
        optionContainerView.addSubview(addOptionButton)
        addOptionButton.addSubview(addImage)
        
        optionContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addOptionButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        addImage.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalTo(24.adjustedW)
            $0.height.equalTo(24.adjustedH)
        }
    }
}
