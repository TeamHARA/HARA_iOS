//
//  WorryDetailFooterView.swift
//  HARA
//
//  Created by 김담인 on 2023/01/11.
//

import UIKit
import SnapKit
import Then

final class WorryDetailFooterView: UICollectionReusableView {
    
    // MARK: - Properties
    private var voteButton = UIButton().then {
        $0.setTitle("투표하기", for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.setTitleColor(.hOrange1, for: .normal)
        $0.isEnabled = false
        $0.setBackgroundColor(.hWhite, for: .disabled)
        $0.setBackgroundColor(.hOrange3, for: .normal)
        $0.makeRounded(cornerRadius: 8)
        $0.layer.borderColor = UIColor.hOrange2.cgColor
        $0.layer.borderWidth = 1
    }
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setLayout() {
        self.addSubview(voteButton)
        
        voteButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
}
