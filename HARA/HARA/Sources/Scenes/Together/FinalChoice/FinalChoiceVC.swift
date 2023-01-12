//
//  FinalChoiceVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/11.
//

import UIKit
import SnapKit
import Then

class FinalChoiceVC: UIViewController {
    
    // MARK: - Properties
    private let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    private let closeDetailButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "detailWorry_close_icon"), for: .normal)
    }
    
    private let finalChoiceTitle = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraH1B20
        $0.text = "두구 두구 나의 최종 결정은?!"
    }
    
    private let finalSubTitle = UILabel().then {
        $0.textColor = .hBlack
        $0.font = .haraH1Sb16
        $0.text = "글자수 제한은 공백 포함 28자 글자수 제한은 공백"
    }
    
    private lazy var finalOptionCV: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
        view.isScrollEnabled = false
        view.backgroundColor = .yellow
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return view
    }()
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(10), trailing: nil, bottom: .fixed(10))
        //        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, repeatingSubitem: item, count: 1)
        //            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        //            group.interItemSpacing = .flexible(-16)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 28
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    private let solveWorryButton = UIButton().then {
        $0.setTitle("고민 해결하기", for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.makeRounded(cornerRadius: 30)

        $0.isEnabled = false
        $0.setBackgroundColor(.hWhite, for: .disabled)
        $0.setTitleColor(.hGray2, for: .disabled)
        $0.layer.borderColor = UIColor.hBlue3.cgColor
        $0.layer.borderWidth = 1
        
        $0.setBackgroundColor(.hOrange1, for: .normal)
        $0.setTitleColor(.hWhite, for: .normal)

    }
    
    private var optionNums = 4
    
    private var worryTitles = ["선택지 글자 수 공백포함 20자"]
    //선택지가 클릭이 된 상태인지를 알려주는 변수
    private var isOptionSelected = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setFinalOptionCV()
        registerCell()
        setLayout()
        setPressAction()
    }
    
    // MARK: - Function
    private func setFinalOptionCV() {
        finalOptionCV.dataSource = self
        finalOptionCV.delegate = self
    }
    
    private func registerCell() {
        finalOptionCV.register(cell: FinalChoiceCVC.self, forCellWithReuseIdentifier: FinalChoiceCVC.className)
    }
    
    private var optionTitle = ""
    
    private func setPressAction() {
        solveWorryButton.press {
            let doneVC = FinalWorryDoneVC()
            doneVC.getOptionTitle(optionTitle: self.optionTitle)
            doneVC.modalPresentationStyle = .overFullScreen
            doneVC.modalTransitionStyle = .flipHorizontal
            self.present(doneVC, animated: true)
        }
        
    }

}

// MARK: - UICollectionViewDataSource
extension FinalChoiceVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return optionNums
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FinalChoiceCVC.className, for: indexPath) as? FinalChoiceCVC else { return UICollectionViewCell() }
        
//        cell.getPercentage(percent: 50)
        
        /// VC의 optionNums를 cell의 optionNums에 전달
//        cell.setCellNums(optionNums: self.optionNums)
//        cell.setData(title: worryTitles[0])
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension FinalChoiceVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? FinalChoiceCVC {
            if cell.isSelected == false {
                // deselectItem을 안해주면 본 didSelectItemAt 함수가 종료될때 cell의 isSelect가 다시 true로 동작함
                collectionView.deselectItem(at: indexPath, animated: false)
                self.solveWorryButton.isEnabled = false
            }else {
                self.optionTitle = cell.sendOptionTitle()
                self.solveWorryButton.isEnabled = true
            }
        }
    }
}

// MARK: - Layout
extension FinalChoiceVC {
    private func setLayout() {
        view.addSubviews([backgroundImage, closeDetailButton, finalChoiceTitle, finalSubTitle, finalOptionCV, solveWorryButton])
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closeDetailButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(63)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(24)
        }
        
        finalChoiceTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(160)
        }
        
        finalSubTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(finalChoiceTitle.snp.bottom).offset(26)
        }
        
        finalOptionCV.snp.makeConstraints {
            $0.top.equalTo(finalSubTitle.snp.bottom).offset(70)
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(268)
        }
        
        solveWorryButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
        }
    }
}
