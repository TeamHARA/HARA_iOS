//
//  StorageNavigationView.swift
//  HARA
//
//  Created by saint on 2023/01/13.
//

import UIKit
import SnapKit
import Then

final class StorageNavigationView: UIView {
    
    // MARK: - Properties
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo_icon")
    }
    
    private let settingButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "setting_icon"), for: .normal)
    }
    
    private let searchButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "storage_Bell"), for: .normal)
    }
    
    // MARK: - Initialization
    override init(frame: CGRect){
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    // MARK: - Layout
    private func setLayout() {
        self.addSubviews([logoImageView, settingButton, searchButton])
        
        logoImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.width.equalTo(50.adjustedW)
            $0.height.equalTo(24.adjustedH)
        }
        
        settingButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview()
            $0.width.height.equalTo(24.adjustedW)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalTo(settingButton.snp.leading).offset(-4)
            $0.width.height.equalTo(24.adjustedW)
        }
    }

}

