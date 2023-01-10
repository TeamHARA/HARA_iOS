//
//  DetailWorryCardVC.swift
//  HARA
//
//  Created by 김담인 on 2023/01/08.
//

import UIKit
import SnapKit
import Then

final class DetailWorryCardVC: UIViewController {
    
    // MARK: - Properties
    private let closeDetailButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "detailWorry_close_icon"), for: .normal)
    }
    
    private let worryStateTitle = UILabel().then {
        $0.font = .haraH1Sb16
        $0.textColor = .hGray1
        $0.text = "고민중"
    }
        
    private lazy var voteOptionCV: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
        view.backgroundColor = .yellow
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        return view
    }()
    
    private var optionNums = 4
    
    static func getLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                let fracHeight = CGFloat(Double(1) / Double(self.optionNums))
                let estimatedHeight = CGFloat(300)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight) )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: .fixed(10))
        //        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
                
        //        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight) )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, repeatingSubitem: item, count: 1)
                //            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        //        group.interItemSpacing = .fixed(10)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind:UICollectionView.elementKindSectionHeader,alignment: .top)
                
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,elementKind:UICollectionView.elementKindSectionFooter,alignment: .bottom)
                
                section.boundarySupplementaryItems = [header, footer]
                
                return UICollectionViewCompositionalLayout(section: section)
            default:
                
            }
            
        }
    }
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let fracHeight = CGFloat(Double(1) / Double(self.optionNums))
        let estimatedHeight = CGFloat(300)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight) )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: .fixed(10))
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0)
        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight) )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, repeatingSubitem: item, count: 1)
        //            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
//        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind:UICollectionView.elementKindSectionHeader,alignment: .top)
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,elementKind:UICollectionView.elementKindSectionFooter,alignment: .bottom)
        
        section.boundarySupplementaryItems = [header, footer]
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setLayout()
        setPressAction()
        setVoteOptionCV()
        
    }
    
    override func viewWillLayoutSubviews() {
         self.voteOptionCV.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Function
    private func setVoteOptionCV() {
        voteOptionCV.dataSource = self
        voteOptionCV.delegate = self
        
        voteOptionCV.register(cell: DetailWorryCVC.self, forCellWithReuseIdentifier: DetailWorryCVC.className)
        voteOptionCV.register(WorryDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WorryDetailHeaderView.className)
        voteOptionCV.register(WorryDetailFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: WorryDetailFooterView.className)
        
    }

    private func setPressAction() {
        self.closeDetailButton.press {
            self.dismiss(animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension DetailWorryCardVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return optionNums
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWorryCVC.className, for: indexPath) as! DetailWorryCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
          case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorryDetailHeaderView.className, for: indexPath) as! WorryDetailHeaderView
            return header
            
          case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorryDetailFooterView.className, for: indexPath) as! WorryDetailFooterView
            return footer
            
          default:
            return UICollectionReusableView()
          }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width
//        return CGSize(width: width, height: 200.adjustedH)
//    }
    
}

// MARK: - UICollectionViewDelegate
extension DetailWorryCardVC: UICollectionViewDelegate {
}

// MARK: - Layout
extension DetailWorryCardVC {
    private func setLayout() {
        view.addSubviews([closeDetailButton, worryStateTitle, voteOptionCV])
        
        closeDetailButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(13)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(24)
        }
        
        worryStateTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(19)
        }
        
        voteOptionCV.snp.makeConstraints {
            $0.top.equalTo(worryStateTitle.snp.bottom).offset(16)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    
    }
}
