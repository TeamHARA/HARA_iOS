//
//  TogetherVC.swift
//  HARA
//
//  Created by 김담인 on 2022/12/27.
//

import UIKit
import SnapKit
import Then

final class TogetherVC: UIViewController {
    
    // MARK: - Properties
    private let togetherNaviView = DefaultNavigationView()
    
    private let categoryCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets.zero
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
    }
    
    private lazy var worryCardCV: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
        view.backgroundColor = .blue
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        return view
    }()
    
    private let categoryTitles = ["전체", "일상", "연애", "패션/뷰티", "커리어", "운동", "여행", "기타"]
    
    /// 고민의 개수
    private var worryNums = 10
    private var worryTitles = ["고민1"]
    private var worryContents = ["dsfsdfdsfdsf"]
    
    /// 선택지의 개수
    private var optionNums = 4
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let calculatedHeight = Double((self.optionNums*50 + 225)).adjustedH
        let estimatedHeight = CGFloat(calculatedHeight)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, repeatingSubitem: item, count: 1)
        
        //            item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: .fixed(10), trailing: nil, bottom: .fixed(10))
        //            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        
        //            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        //            group.interItemSpacing = .flexible(-16)
        //
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        //        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        setCategoryCV()
        registerCell()
        setLayout()
        categoryCV.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .right)
    }
    
    // MARK: - Function
    private func setCategoryCV() {
        categoryCV.dataSource = self
        categoryCV.delegate = self
        
        worryCardCV.dataSource = self
        worryCardCV.delegate = self
    }
    
    private func registerCell() {
        categoryCV.register(cell: CategoryCVC.self, forCellWithReuseIdentifier: CategoryCVC.className)
        
        worryCardCV.register(cell: WorryCardCVC.self, forCellWithReuseIdentifier: WorryCardCVC.className)
    }
    
    func calculateLabelHeight(index: Int) -> CGFloat {
        let label = UILabel()
        label.text = worryContents[index]
        label.font = .haraB2M14
        return label.frame.height
    }
    
}
// MARK: - UICollectionViewDelegateFlowLayout
extension TogetherVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCV {
            let sizingCell = CategoryCVC()
            sizingCell.setData(data: categoryTitles[indexPath.row])
            sizingCell.categoryLabel.sizeToFit()
            
            let cellWidth = sizingCell.categoryLabel.frame.width + 24
            let cellHeight = CGFloat(31)
            return CGSize(width: cellWidth, height: cellHeight)
        }else {
            return .zero
        }
    }
}


// MARK: - UICollectionViewDataSource
extension TogetherVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCV {
            return 8
        }else {
            return worryNums
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexPath) as? CategoryCVC
            else { return UICollectionViewCell() }
            cell.setData(data: categoryTitles[indexPath.row])
            if indexPath.row != 0 {
                cell.contentView.layer.borderColor = UIColor.hBlue2.cgColor
                cell.contentView.layer.borderWidth = 1
            }
            return cell
        }else if collectionView == worryCardCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorryCardCVC.className, for: indexPath) as? WorryCardCVC else { return UICollectionViewCell() }
            
            /// VC의 optionNums를 cell의 optionNums에 전달
            cell.setCellNums(optionNums: self.optionNums)
            cell.setData(title: worryTitles[0], content: worryContents[0])
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
}

// MARK: - UICollectionViewDelegate
extension TogetherVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailWorryCardVC()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

// MARK: - Layout
extension TogetherVC {
    private func setLayout() {
        self.view.addSubviews([togetherNaviView, categoryCV, worryCardCV])
        
        togetherNaviView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24.adjustedH)
        }
        
        categoryCV.snp.makeConstraints {
            $0.top.equalTo(togetherNaviView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(31)
        }
        
        worryCardCV.snp.makeConstraints {
            $0.top.equalTo(categoryCV.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.bottom.equalToSuperview().inset(12)
        }
        
    }
    
}

