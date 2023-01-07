//
//  WorriedAloneVC.swift
//  HARA
//
//  Created by 누리링 on 2023/01/06.
//

import UIKit
import SnapKit
import Then
import Moya


class AloneWorriedVC: UIViewController {
            
    private let worriedAllButton = UIButton().then {
        $0.setImage(UIImage(named: "storage_ing_all"), for: .normal)
    }
    
    private let editButton = UIButton().then {
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(.hBlack, for: .normal)
        $0.titleLabel?.font = .haraB2M14
    }

//    private lazy var aloneCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
//        //UICollectionViewFlowLayout의 인스턴스를 생성
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        $0.backgroundColor = .clear
//        $0.isScrollEnabled = true
//        $0.showsVerticalScrollIndicator = false
//        $0.delegate = self
//        $0.dataSource = self
//
//    }
    
    
    private lazy var aloneCollectionView : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    // MARK: - Constants
    /// 셀 - 한 개 사이즈, 위치 지정
    final let aloneInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 12, bottom: 10, right: 12)
    
    ///여기부분 다시 보기 / section별, item별로 부여할 여백 상수로 저장
    final let aloneLineSpacing: CGFloat = 10
    final let aloneItemSpacing: CGFloat = 19
    final let aloneCellHeight: CGFloat = 100
    
    var worriedList: [WorriedAloneModel] = [
        WorriedAloneModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 땡벌", date: "2022.12.25"),
        WorriedAloneModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        WorriedAloneModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        WorriedAloneModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        WorriedAloneModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25"),
        WorriedAloneModel(worring: "storage_ing", categoryTitle: "일상", mainText: "난 이제 지쳤어요 멍멍", date: "2022.12.25")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        cellView()
        register()
    }
}


extension AloneWorriedVC {
    // 수직 스크롤이라는 가정 하에, rowCount는 몇개의 행을 사용할지를 저장한 변수

    private func cellView() {
        view.backgroundColor = .clear
        view.addSubview(aloneCollectionView)
        aloneCollectionView.snp.makeConstraints{
            $0.top.equalTo(40.adjustedH)
            $0.trailing.equalTo(2.adjustedW).inset(7)
            $0.leading.equalTo(2.adjustedW).inset(3)
            $0.height.equalTo(calculateCellHeight())
        }
    }
    private func register() {
        aloneCollectionView.register(
            AloneWorriedCVC.self, forCellWithReuseIdentifier: AloneWorriedCVC.identifier)
    }
    
    private func calculateCellHeight() -> CGFloat{
        let counting = CGFloat(worriedList.count)
//        let heightCount = counting / 3 + counting.truncatingRemainder(dividingBy: 3)
//        return counting * aloneCellHeight + (counting - 1) * aloneLineSpacing + aloneInset.top + aloneInset.bottom
        return counting * aloneCellHeight
    }

}


// MARK: - UICollectionViewDelegateFlowLayout

extension AloneWorriedVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let itemCellWidth = screenWidth - aloneInset.left - aloneInset.right - aloneItemSpacing
        return CGSize(width: itemCellWidth, height: 90)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return aloneItemSpacing
//    }
//    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInterLineSpacingForSectionAt section: Int) -> CGFloat {
//        return aloneLineSpacing
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return aloneInset
//    }
}



// MARK: -UICollectionViewDataSource
extension AloneWorriedVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return worriedList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let aloneCell = collectionView.dequeueReusableCell(withReuseIdentifier: AloneWorriedCVC.identifier, for: indexPath) as? AloneWorriedCVC else { return UICollectionViewCell() }
        aloneCell.dataBind(model: worriedList[indexPath.item])
        return aloneCell
    }
}

//MARK: Layout
extension AloneWorriedVC {
    private func setLayout() {
        view.addSubview(aloneCollectionView)
        [worriedAllButton, editButton].forEach {
            view.addSubview($0)
        }
        worriedAllButton.snp.makeConstraints{
            $0.top.equalTo(10.adjustedH)
            $0.leading.equalTo(2.adjustedW).inset(7)
        }
        editButton.snp.makeConstraints{
            $0.top.equalTo(10.adjustedH)
            $0.trailing.equalTo(2.adjustedW).inset(12)
        }
    }
}

    
