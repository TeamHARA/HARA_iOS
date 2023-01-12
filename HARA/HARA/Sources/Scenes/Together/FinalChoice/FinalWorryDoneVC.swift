//
//  FinalWorryDoneVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/12.
//

import UIKit
import SnapKit
import Then

class FinalWorryDoneVC: UIViewController {
    
    // MARK: - Properties
    private let backGroundView = UIImageView().then {
        $0.image = UIImage(named: "finalBackground_img")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    private let finalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 26.adjustedH
//        $0.backgroundColor = .green
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    private let finalDoneTitleImage = UIImageView().then {
        $0.image = UIImage(named: "final_title_img")
        $0.contentMode = .scaleAspectFit
    }
    
    private let worryTitle = UILabel().then {
        $0.font = .haraM2M18
        $0.textColor = .hBlack
        $0.text = "오늘 몇시까지 작업할까?"
    }
    
    private let chosenOptionImage = UIImageView().then {
        $0.image = UIImage(named: "dummy1_img")
        $0.contentMode = .scaleAspectFit
    }
    
    private let chosenOptionTitle = UILabel().then {
        $0.textColor = .hWhite
        $0.backgroundColor = .hBlack
        $0.layer.borderColor = UIColor.hGray2.cgColor
        $0.layer.borderWidth = 1
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.font = .haraM2M18
        $0.text = "하고 싶을때 하자~"
    }
    

    private let moveToStorageButton = UIButton().then {
        $0.setTitleWithCustom("보관함으로 이동하기 >", font: .haraB2M14, color: .hBlack, for: .normal)
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setPress()
    }
    
    // MARK: - Function
    private func setPress() {
        
        /// 보관함으로 이동
        moveToStorageButton.press {
            self.dismiss(animated: true)
        }
    }
    func getOptionTitle(optionTitle: String){
        chosenOptionTitle.text = optionTitle
    }
    
    func removeImage() {
        chosenOptionImage.removeFromSuperview()
        finalStackView.snp.updateConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(362.adjustedH)
        }
    }
}

// MARK: - Layout
extension FinalWorryDoneVC {
    private func setLayout() {
        self.view.addSubviews([backGroundView, finalStackView, moveToStorageButton])
        finalStackView.addArrangedSubviews([finalDoneTitleImage, worryTitle, chosenOptionImage, chosenOptionTitle])
        
        backGroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        finalStackView.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(311.adjustedH)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(342.adjustedW)
//            $0.height.equalTo(339.adjustedH)
        }
        
        chosenOptionTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(46)
        }

//        chosenOptionImage.snp.makeConstraints {
//            $0.height.equalTo(0)
//        }
        
        moveToStorageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
        
    }
}
