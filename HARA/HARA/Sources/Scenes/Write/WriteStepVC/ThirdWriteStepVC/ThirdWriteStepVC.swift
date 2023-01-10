//
//  ThirdStepView.swift
//  HARA
//
//  Created by saint on 2023/01/03.
//

import UIKit
import SnapKit
import Then

class ThirdWriteStepVC: UIViewController{
    
    // MARK: - Properties
    private let background = UIImageView().then {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
    }
    
    lazy var navigationView = UIView().then{
        $0.backgroundColor = .hBlue4
    }
    
    lazy var progressView = UIView().then{
        $0.backgroundColor = .hBlue1
    }
    
    private let questionLabel = UILabel().then{
        $0.numberOfLines = 2
        let normalString1 = NSAttributedString(string: "선택지의\n", attributes: [
            .font: UIFont.haraM1M24])
        let boldString = NSAttributedString(string: "장단점", attributes: [
            .font: UIFont.haraM1B24])
        let normalString2 = NSAttributedString(string: "을 적어보세요.", attributes: [
            .font: UIFont.haraM1M24])
        
        let title = normalString1 + boldString + normalString2
        $0.attributedText = title
    }
    
    private let tipLabel = UILabel().then{
        $0.text = "장단점은 스킵할 수 있어요."
        $0.font = .haraB3R14
        $0.textColor = .hGray2
    }
    
//    private lazy var scrollView = UIScrollView().then{
//        $0.backgroundColor = .yellow
//    }
//
//    private lazy var firstProsConsView = ProsConsView()
//    private lazy var secondProsConsView = ProsConsView()
//    private lazy var thirdProsConsView = ProsConsView()
//    private lazy var fourthProsConsView = ProsConsView()
//
//    private lazy var stackProsConsArray: [ProsConsView] = []
//
//    private lazy var pcStackView = UIStackView(arrangedSubviews: [firstProsConsView, secondProsConsView, thirdProsConsView, fourthProsConsView]).then {
//        $0.axis = .vertical // default
//        $0.distribution = .fillProportionally // default
//        $0.alignment = .fill // default
//        $0.spacing = 14.adjustedH
//        $0.backgroundColor = .red
//    }
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    
    private lazy var prosConsCV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then{

        //$0.showsHorizontalScrollIndicator = true
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
    }
    
    final let listLineSpacing: CGFloat = 14.adjustedH
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setLayout()
        registerCV()
    }
    
    // MARK: - Functions
    private func registerCV() {
        prosConsCV.register(ProsConsCVC.self,
                                forCellWithReuseIdentifier: ProsConsCVC.classIdentifier
        )
    }
}

// MARK: - Layout
extension ThirdWriteStepVC{
    private func setLayout(){
        view.addSubViews([background, navigationView, progressView, questionLabel, tipLabel,
                         prosConsCV])
        
        background.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(4.adjustedH)
            $0.width.equalTo(UIScreen.main.bounds.size.width)
        }
        
        progressView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(4.adjustedH)
            $0.width.equalTo((UIScreen.main.bounds.size.width/4)*3)
        }
        
        questionLabel.snp.makeConstraints{
            $0.top.equalTo(navigationView.snp.bottom).offset(70.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
        }
        
        tipLabel.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(6.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
        }
        
        prosConsCV.snp.makeConstraints{
            $0.top.equalTo(tipLabel.snp.bottom).offset(10.adjustedH)
            $0.leading.equalToSuperview().offset(16.adjustedW)
            $0.trailing.equalToSuperview().offset(-16.adjustedW)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ThirdWriteStepVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343.adjustedW, height: 153.adjustedH)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return listLineSpacing
    }
}

// MARK: - UICollectionViewDataSource

extension ThirdWriteStepVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4//imageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let prosConsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProsConsCVC.classIdentifier, for: indexPath)
                as? ProsConsCVC else { return UICollectionViewCell() }
        //imageCell.dataBind(model: imageList[indexPath.item])
        return prosConsCell
    }
}

