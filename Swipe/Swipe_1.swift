//
//  New.swift
//  Swipe
//
//  Created by MuhammadAli on 08/12/23.
//

import UIKit

let windowWidth = UIScreen.main.bounds.width
let windowHeight = UIScreen.main.bounds.height
let leftRightSpacing: CGFloat = 20
let spacing: CGFloat = 10
let buttonWidth = (windowWidth - 40 - 50) / 4
let buttonArea = windowWidth - leftRightSpacing * 2
let topSpacingForButtonArea = (windowHeight - buttonArea) / 2


class New: UIViewController {
    
    var btnArray: [UIButton] = []
    
    var btnContainer = UIView()
    
    var chack = [
    [0,4,8,12],
    [1,5,9,13],
    [2,6,10,14],
    [3,7,11,15]
    ]
    
    var winList = [
    [0,1,2,3],     // 0.up
    [0,4,8,12],    // 1.left
    [12,13,14,15], // 2.down
    [3,7,11,15]    // 3.right
    ]
    
    var img = UIImage()
    
    let images: [UIImage] = [
        UIImage(named: "chameleon")!,
        UIImage(named: "corgi")!,
        UIImage(named: "panda")!,
        UIImage(named: "dragonfly")!,
        UIImage(named: "shark")!,
        UIImage(named: "siamese-cat")!,
        UIImage(named: "smile")!,
        UIImage(named: "smiling")!,
        UIImage(named: "snail")!,
        UIImage(named: "tiger")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .qizil
        setupUI()
        swipe()
        selectImages()
    }
    
    func setupUI() {
        let topLabel = UILabel()
        topLabel.frame = CGRect(
            x: leftRightSpacing,
            y: leftRightSpacing * 4,
            width: windowWidth - leftRightSpacing * 2,
            height: 50)
        topLabel.textAlignment = .center
        topLabel.font = .boldSystemFont(ofSize: 32)
        topLabel.textColor = .sariq
        topLabel.text = "Swipe"
        topLabel.layer.cornerRadius = 12
        topLabel.layer.borderColor = UIColor.sariq.cgColor
        topLabel.layer.borderWidth = 3
        self.view.addSubview(topLabel)
        
        
        
        btnContainer.frame = CGRect(
            x: leftRightSpacing,
            y: topSpacingForButtonArea ,
            width: buttonArea,
            height: buttonArea)
        btnContainer.backgroundColor = .qizil
        btnContainer.layer.cornerRadius = 12
        btnContainer.layer.borderColor = UIColor.sariq.cgColor
        btnContainer.layer.borderWidth = 3
        self.view.addSubview(btnContainer)
        
        for i in 0...3 {
            for j in 0...3 {
                let button = UIButton()
                button.frame = CGRect(
                    x: spacing + CGFloat(j) * (spacing + buttonWidth),
                    y: spacing + CGFloat(i) * (spacing + buttonWidth),
                    width: buttonWidth,
                    height: buttonWidth)
                button.tag = i * 4 + j
                button.setTitleColor(UIColor.black, for: .normal)
                button.layer.cornerRadius = 12
                button.backgroundColor = .sariq
                button.isUserInteractionEnabled = false
                btnArray.append(button)
                btnContainer.addSubview(button)
            }
        }
        
        let bottomBtn = UIButton(
            frame: CGRect(
                x: leftRightSpacing,
                y: windowHeight - 52 - leftRightSpacing * 3,
                width: windowWidth - leftRightSpacing * 2,
                height: 52))
        bottomBtn.titleLabel?.font = .boldSystemFont(ofSize: 32)
        bottomBtn.layer.cornerRadius = 12
        bottomBtn.setTitleColor(.sariq, for: .normal)
        bottomBtn.layer.borderColor = UIColor.sariq.cgColor
        bottomBtn.layer.borderWidth = 3
        bottomBtn.setTitle("more", for: .normal)
        bottomBtn.addTarget(self, action: #selector(morePressed), for: .touchUpInside)
        self.view.addSubview(bottomBtn)
    }
    
    @objc func morePressed() {
        selectImages()
    }
    
    func selectImages() {
        clearAll()
        img = images.randomElement()!
        btnArray[Int.random(in: 0...3)].setImage(img, for: .normal)
        btnArray[Int.random(in: 4...7)].setImage(img, for: .normal)
        btnArray[Int.random(in: 8...11)].setImage(img, for: .normal)
        btnArray[Int.random(in: 12...15)].setImage(img, for: .normal)
    }
    
    func clearAll() {
        for i in btnArray {
            i.setImage(.none, for: .normal)
        }
    }
    
    func alert() {
        let alert = UIAlertController(
            title: "Error🙈",
            message: "bu tomonga surib bulmaydi 🤓",
            preferredStyle: .alert)
        let ok = UIAlertAction(title: "Xop 🙃", style: .default) { _ in
            self.selectImages()
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func swipe() {
        let left: UISwipeGestureRecognizer = .init(target: self, action: #selector(leftSwipe))
        left.direction = .left
        self.btnContainer.addGestureRecognizer(left)
        
        let right: UISwipeGestureRecognizer = .init(target: self, action: #selector(rightSwipe))
        right.direction = .right
        self.btnContainer.addGestureRecognizer(right)
        
        let up: UISwipeGestureRecognizer = .init(target: self, action: #selector(upSwipe))
        up.direction = .up
        self.btnContainer.addGestureRecognizer(up)
        
        let down: UISwipeGestureRecognizer = .init(target: self, action: #selector(downSwipe))
        down.direction = .down
        self.btnContainer.addGestureRecognizer(down)
        
    }
    
    @objc func leftSwipe() {
        clearAll()
        for index in winList[1] {
            btnArray[index].setImage(img, for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
            self.selectImages()
        }
        print("left")
    }
    
    @objc func rightSwipe() {
        clearAll()
        for index in winList[3] {
            btnArray[index].setImage(img, for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.selectImages()
        }
        print("right")
    }
    
    @objc func upSwipe() {
        if logic() {
            clearAll()
            for index in winList[0] {
                btnArray[index].setImage(img, for: .normal)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.selectImages()
            }
        } else {
            alert()
        }
        print("up")
    }
    
    @objc func downSwipe() {
        if logic() {
            clearAll()
            for index in winList[2] {
                btnArray[index].setImage(img, for: .normal)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.selectImages()
            }
        } else {
            alert()
        }
        print("down")
    }
    
    func logic() -> Bool {
        var rowImgNum = 0
        var amount = 0
        for i in chack {
            for index in i {
                if btnArray[index].currentImage != nil {
                    rowImgNum += 1
                }
            }
            if rowImgNum == 1 {
                amount += 1
                
            }
            rowImgNum = 0
            
            if amount == 4 {
                return true
            }
        }
        amount = 0
        return false
    }
}
