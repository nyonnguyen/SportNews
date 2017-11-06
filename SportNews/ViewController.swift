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
    let cellSize = CGSize(width: 250, height: 200)
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
    
    let logoBoundView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "padRing")
        view.translatesAutoresizingMaskIntoConstraints = false
        let layer = CAGradientLayer()
        layer.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        view.layer.insertSublayer(layer, at: 0)
        return view
    }()
    
//    let logoBoundView: GradientView = {
//        let view = GradientView()
//        view.startColor = UIColor.blue
//        view.endColor = UIColor.red
//        view.opacityValue = 1
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    let cupLogoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "UEFA-logo")
        //view.backgroundColor = UIColor.blue
        return view
    }()
    
    let rankText: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(white: 1, alpha: 0.9)
        text.font = UIFont.boldSystemFont(ofSize: 48)
        text.text = "0"
        text.numberOfLines = 1
        text.baselineAdjustment = .alignBaselines
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        //text.backgroundColor = UIColor.red
        return text
    }()
    
    let rankLogoContainer: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let clubName: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(white: 1, alpha: 0.9)
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text = "Club Name Here"
        text.numberOfLines = 1
        text.baselineAdjustment = .alignBaselines
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    func createARGBBitmapContextFromImage(inImage: CGImage) -> CGContext? {
        
        let width = inImage.width
        let height = inImage.height
        
        let bitmapBytesPerRow = width * 4
        let bitmapByteCount = bitmapBytesPerRow * height
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // if colorSpace == nil {
        // return nil
        // }
        
        let bitmapData = malloc(bitmapByteCount)
        if bitmapData == nil {
            return nil
        }
        
        let context = CGContext (data: bitmapData,
                                 width: width,
                                 height: height,
                                 bitsPerComponent: 8, // bits per component
            bytesPerRow: bitmapBytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        return context
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        rankLogoContainer.addSubview(rankText)
        rankLogoContainer.addSubview(logoBoundView)
        rankLogoContainer.addSubview(logoView)
        rankLogoContainer.addSubview(cupLogoView)
        
        self.view.addSubview(bgImage)
        self.view.addSubview(bgView)
        self.view.addSubview(clubName)
        self.view.addSubview(rankLogoContainer)
        self.view.addSubview(collectionView)
        
        
        bgImage.frame = view.frame
        bgView.frame = view.frame

        
        let clubNameHeight: CGFloat = 50
        let cvHeight = view.frame.height * 0.42
        
        let blockWidth: CGFloat = 80
        let containerWidth: CGFloat = blockWidth + (blockWidth*0.4)
        let cvTop = view.frame.height * 0.44 - clubNameHeight - blockWidth
        let innerSpace: CGFloat = 0
        let outerSpace = (view.frame.width - blockWidth*3 - innerSpace)/2
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": rankLogoContainer]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[v2(cWidth)]-10-[v1(nameHeight)]-10-[v0(height)]", options: NSLayoutFormatOptions(), metrics: ["height": cvHeight, "top": cvTop, "nameHeight": clubNameHeight, "cWidth": containerWidth], views: ["v0": collectionView, "v1": clubName, "v2": rankLogoContainer]))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": clubName]))
        
//        self.rankLogoContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: ["oSpace": outerSpace, "iSpace": innerSpace, "bw": blockWidth], views: ["v0": logoBoundView]))
//        self.rankLogoContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: ["oSpace": outerSpace, "iSpace": innerSpace, "bw": blockWidth], views: ["v0": logoBoundView]))
        
        logoView.centerXAnchor.constraint(equalTo: self.rankLogoContainer.centerXAnchor).isActive = true
        logoBoundView.centerXAnchor.constraint(equalTo: self.logoView.centerXAnchor).isActive = true
        
        self.rankLogoContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v2(bw)]-iSpace-[v0(bw)][v3]-iSpace-[v1(bw)]|", options: NSLayoutFormatOptions(), metrics: ["oSpace": outerSpace, "iSpace": innerSpace, "bw": blockWidth], views: ["v0": logoView, "v1": cupLogoView, "v2": rankText, "v3": logoBoundView]))

        self.rankLogoContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": logoBoundView]))
        
        logoView.centerYAnchor.constraint(equalTo: self.rankLogoContainer.centerYAnchor).isActive = true
        logoBoundView.centerYAnchor.constraint(equalTo: self.rankLogoContainer.centerYAnchor).isActive = true
        cupLogoView.centerYAnchor.constraint(equalTo: self.rankLogoContainer.centerYAnchor).isActive = true
        rankText.centerYAnchor.constraint(equalTo: self.rankLogoContainer.centerYAnchor).isActive = true
        
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
        
        self.rankText.text = String(self.items[self.pageIndex].rank)
    }
    
    func updateViewWhenChange() {
        if (pageIndex != previousIndex) {
            UIView.animate(withDuration: 0.2, animations: {
                self.bgImage.layer.opacity = 0.3
                self.bgView.layer.opacity = 0.3
                self.clubName.layer.opacity = 0.3
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








