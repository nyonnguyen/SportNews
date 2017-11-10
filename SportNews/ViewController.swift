//
//  ViewController.swift
//  SportNews
//
//  Created by Nyon Nguyen on 10/26/17.
//  Copyright © 2017 Nyon Nguyen. All rights reserved.
//

import UIKit

class MyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {

    var items = [
                Player(rank: 6, avatar: "1", name: "Lionel Messi", number: 10, club: ClubEnum.BARCALONA.getData()),
                Player(rank: 5, avatar: "2", name: "Cristiano Ronaldo", number: 7, club: ClubEnum.REALMARID.getData()),
                Player(rank: 3, avatar: "3", name: "Wayne Rooney", number: 10, club: ClubEnum.MANU.getData()),
                Player(rank: 4, avatar: "4", name: "David Silva", number: 21, club: ClubEnum.MANC.getData()),
                Player(rank: 2, avatar: "5", name: "Aaron Ramsey", number: 8, club: ClubEnum.ASERNAL.getData()),
                Player(rank: 1, avatar: "6", name: "James Milner", number: 7, club: ClubEnum.LIVERPOOL.getData())
                ]
    
    var pageIndex: Int = 0
    var previousIndex: Int = 0
    var cellSize = CGSize(width: 300, height: 250)
    let spaceBetweenCells = CGFloat(20)
    var pageSize: CGFloat {
        return CGFloat(spaceBetweenCells + cellSize.width)
    }
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        //cv.contentInset = UIEdgeInsetsMake(0, 30, 0, 30)
        //cv.isPagingEnabled = true
        cv.bounces = true
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let bgImage: UIImageView = {
        let bg = UIImageView()
        bg.contentMode = .scaleAspectFill
        bg.image = UIImage(named: "")
        bg.layer.opacity = 0.8
        return bg
    }()
    
    let bgView: GradientView = {
        let view = GradientView()
        view.startColor = UIColor.blue
        view.endColor = UIColor.red
        view.opacityValue = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoBoundView: GradientView = {
        let view = GradientView()
        view.startColor = UIColor.blue
        view.endColor = UIColor.red
        view.opacityValue = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.gray
        let mask = UIImageView(image: UIImage(named: "padRing"))
        mask.contentMode = .scaleAspectFit
        view.mask = mask
        return view
    }()
    
    let cupLogoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "UEFA-logo")
        //view.backgroundColor = UIColor.blue
        return view
    }()
    
    let rankNum: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(white: 1, alpha: 0.9)
        text.font = UIFont(name: "LucidaGrande-Bold", size: 36)
        text.text = "1"
        text.numberOfLines = 1
        text.baselineAdjustment = .alignBaselines
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let rankNumText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(white: 1, alpha: 0.9)
        text.font = UIFont(name: "LucidaGrande-Bold", size: 12)
        text.text = "th"
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let rankPlaceText: UILabel = {
        let text = UILabel()
        text.text = "Current place"
        text.font = UIFont(name: "LucidaGrande-Bold", size: 11)
        text.textColor = UIColor(white: 1, alpha: 0.9)
        text.baselineAdjustment = .alignBaselines
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let rankTextBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = UIColor.gray
        return view
    }()
    
    let rankLogoContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let clubName: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(white: 1, alpha: 0.9)
        text.font = UIFont(name: "LucidaGrande-Bold", size: 24)
        text.text = "Club Name Here"
        text.numberOfLines = 1
        text.baselineAdjustment = .alignBaselines
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let stadiumIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "stadium")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let stadiumBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Etihad Stadium", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "LucidaGrande-Bold", size: 10)
        button.setTitleColor(UIColor(white: 1, alpha: 0.7), for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let webIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "link")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let webBtn: UIButton = {
        let button = UIButton()
        button.setTitle("www.clubwebsite.com", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "LucidaGrande-Bold", size: 10)
        button.setTitleColor(UIColor(white: 1, alpha: 0.7), for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let moreInfoBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ratioSize = cellSize.width/375
        cellSize = CGSize(width: cellSize.width*ratioSize, height: cellSize.height*ratioSize)
        
        // sort player by rank
        sortItemRank()
        
        setupViews()
        
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    func sortItemRank() {
        items = items.sorted(by: { (p1, p2) -> Bool in
            return p1.rank < p2.rank
        })
    }
    
    func setupViews() {
        
        rankTextBox.addSubview(rankNum)
        rankTextBox.addSubview(rankNumText)
        rankTextBox.addSubview(rankPlaceText)
        rankLogoContainer.addSubview(rankTextBox)
        rankLogoContainer.addSubview(logoBoundView)
        rankLogoContainer.addSubview(logoView)
        rankLogoContainer.addSubview(cupLogoView)
        
        moreInfoBox.addSubview(stadiumIcon)
        moreInfoBox.addSubview(stadiumBtn)
        moreInfoBox.addSubview(barView)
        moreInfoBox.addSubview(webIcon)
        moreInfoBox.addSubview(webBtn)
        
        self.view.addSubview(bgImage)
        self.view.addSubview(bgView)
        self.view.addSubview(rankLogoContainer)
        self.view.addSubview(clubName)
        self.view.addSubview(moreInfoBox)
        self.view.addSubview(collectionView)
        
        bgImage.frame = view.frame
        bgView.frame = view.frame

        
        let clubNameHeight: CGFloat = 28
        let cvHeight = view.frame.height * 0.42
        let logoBoundWidth: CGFloat = 150
        let blockWidth: CGFloat = 80
        let containerWidth: CGFloat = blockWidth + (blockWidth*0.4)
        let bottomBar: CGFloat = 40
        let cvTop = view.frame.height*0.12
        let innerContainerSpace: CGFloat = 0
        let outerContainerSpace = (view.frame.width - logoBoundWidth - blockWidth*2)/4
        let rankNumSize: CGFloat = 42
        let rankPlaceTextSize: CGFloat = 12
        let rankSpace = blockWidth - rankNumSize - rankPlaceTextSize
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": rankLogoContainer]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
        // bottom bar is not added yet
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[v2(cWidth)][v1(nameHeight)]-10-[v3(20)]-20-[v0(height)]", options: NSLayoutFormatOptions(), metrics: ["height": cvHeight, "top": cvTop, "nameHeight": clubNameHeight, "cWidth": containerWidth], views: ["v0": collectionView, "v1": clubName, "v2": rankLogoContainer, "v3": moreInfoBox]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": clubName]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": moreInfoBox]))
        
        // more info box
        self.barView.centerXAnchor.constraint(equalTo: self.moreInfoBox.centerXAnchor).isActive = true
        self.stadiumIcon.centerYAnchor.constraint(equalTo: self.moreInfoBox.centerYAnchor).isActive = true
        self.stadiumBtn.centerYAnchor.constraint(equalTo: self.moreInfoBox.centerYAnchor).isActive = true
        self.webIcon.centerYAnchor.constraint(equalTo: self.moreInfoBox.centerYAnchor).isActive = true
        self.webBtn.centerYAnchor.constraint(equalTo: self.moreInfoBox.centerYAnchor).isActive = true
        
        self.moreInfoBox.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(12)]-10-[v1]-30-[v2(2)]-30-[v3(12)]-5-[v4]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": stadiumIcon, "v1": stadiumBtn, "v2": barView, "v3": webIcon, "v4": webBtn]))
        self.moreInfoBox.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v2]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": stadiumIcon, "v1": stadiumBtn, "v2": barView, "v3": webIcon, "v4": webBtn]))
        
        // Rank box
        logoView.centerXAnchor.constraint(equalTo: self.rankLogoContainer.centerXAnchor).isActive = true
        logoBoundView.centerXAnchor.constraint(equalTo: self.logoView.centerXAnchor).isActive = true
        
        self.rankLogoContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v2(bw)]-oSpace-[v3(lbw)]-oSpace-[v1(bw)]", options: NSLayoutFormatOptions(), metrics: ["oSpace": outerContainerSpace, "iSpace": innerContainerSpace, "bw": blockWidth, "lbw": logoBoundWidth], views: ["v0": logoView, "v1": cupLogoView, "v2": rankTextBox, "v3": logoBoundView]))
        
        
        self.rankLogoContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": logoBoundView]))
        
        self.rankLogoContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": rankTextBox]))
        
        
        self.rankTextBox.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-space-[v0][v1(14)]-space-|", options: NSLayoutFormatOptions(), metrics: ["space": rankSpace], views: ["v0": rankNum, "v1": rankPlaceText]))
        
        rankNumText.topAnchor.constraint(equalTo: self.rankNum.topAnchor).isActive = true
        rankNum.centerXAnchor.constraint(equalTo: rankTextBox.centerXAnchor).isActive = true
        self.rankTextBox.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0][v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": rankNum, "v1": rankNumText]))
        self.rankTextBox.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": rankPlaceText]))
        
        logoView.centerYAnchor.constraint(equalTo: self.rankLogoContainer.centerYAnchor).isActive = true
        logoBoundView.centerYAnchor.constraint(equalTo: self.rankLogoContainer.centerYAnchor).isActive = true
        cupLogoView.centerYAnchor.constraint(equalTo: self.rankLogoContainer.centerYAnchor).isActive = true
        
        loadDataToView()
    }
    
    func loadDataToView() {
        self.bgImage.image = UIImage(named: self.items[self.pageIndex].club.background)
        self.bgImage.layer.opacity = 1
        
        self.bgView.startColor = self.items[self.pageIndex].club.colors[0]
        self.bgView.endColor = self.items[self.pageIndex].club.colors[1]
        self.bgView.layer.opacity = 1
        
        self.clubName.text = self.items[self.pageIndex].club.fullName.capitalized
        self.clubName.layer.opacity = 1
        
        self.logoView.image = UIImage(named: self.items[self.pageIndex].club.logo)
        self.logoView.layer.opacity = 1
        
        self.rankNum.text = String(self.items[self.pageIndex].rank)
        self.rankNum.layer.opacity = 1
        
        self.logoBoundView.startColor = self.items[self.pageIndex].club.colors[0]
        self.logoBoundView.endColor = self.items[self.pageIndex].club.colors[1]
        
        self.rankNumText.text = orderNumberToText(num: self.items[self.pageIndex].rank)
        
        self.webBtn.setTitle(self.items[self.pageIndex].club.website, for: UIControlState.normal)
    }
    
    func orderNumberToText(num: Int) -> String {
        if num == 1 { return "st" }
        else if num == 2 { return "nd" }
        else if num == 3 { return "rd" }
        else { return "th" }
    }
    
    func updateViewWhenChange() {
        if (pageIndex != previousIndex) {
            UIView.animate(withDuration: 0.2, animations: {
                self.bgImage.layer.opacity = 0.3
                self.bgView.layer.opacity = 0.3
                self.clubName.layer.opacity = 0.3
                self.logoView.layer.opacity = 0.3
                self.rankNum.layer.opacity = 0.3
            }) { (done) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.loadDataToView()
                })
            }
            previousIndex = pageIndex
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MyCell
        let index = indexPath.item
        cell.avatar.image = UIImage(named: items[index].avatar)
        cell.nameLabel.text = items[index].name.capitalized
        cell.numberLabel.text = String(items[index].number)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetweenCells
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // size of page is depended on cells and space between them.
        // size of a page is calculated by adding the space between cells and the width of cell
        // scroll possition
        let xOffset = scrollView.contentOffset.x
        // the page index is caculated by:
        pageIndex = Int(floor((xOffset - pageSize / 2) / pageSize) + 1)
        //print(pageIndex)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollView.setContentOffset(CGPoint(x: (pageSize)*CGFloat(pageIndex), y: scrollView.contentOffset.y), animated: true)
        updateViewWhenChange()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: (pageSize)*CGFloat(pageIndex), y: scrollView.contentOffset.y), animated: true)
        updateViewWhenChange()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, (self.view.frame.width/2) - (self.cellSize.width/2), 0, (self.view.frame.width/2) - (self.cellSize.width/2))
    }
}





