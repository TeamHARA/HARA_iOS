//
//  WriteVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/02.
//

import UIKit
import SnapKit
import Then

class WriteVC: UIViewController {
    /// background에 Image 넣기
    private let background = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .red
    }

    // MARK: - UI Components
    private let closeButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "icn_close"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(touchupCloseButton), for: .touchUpInside)
    }

    private let titleLabel = UILabel().then {
        $0.text = "고민작성하기"
        $0.font = .systemFont(ofSize: 16.adjustedW, weight: .semibold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .clear
        setlayout()
    }
    
    @objc
    private func touchupCloseButton(){
        if self.navigationController == nil{
            self.dismiss(animated: true, completion: nil)
        }
        self.navigationController?.dismiss(animated: true)
    }
}

extension WriteVC{
    
    private func setlayout(){
        
        self.view.insertSubview(background, at: 0)
        
        background.snp.makeConstraints{
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        view.addSubViews([closeButton, titleLabel])
        
        closeButton.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(13.adjustedH)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16.adjustedW)
            $0.width.equalTo(24.adjustedW)
            $0.height.equalTo(24.adjustedH)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}





