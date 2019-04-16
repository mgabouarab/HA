//
//  GalaryViewController.swift
//  HA
//
//  Created by Mohammed Abouarab on 4/11/19.
//  Copyright © 2019 Mohammed Abouarab. All rights reserved.
//

import UIKit

class GalaryViewController: UIViewController {
    
    let imagesName = ["Galary Image 1","Galary Image 2","Galary Image 3","Galary Image 4"]
    var currentImageIndex = 0
    let VC = ViewController()

    @IBOutlet var mainGalaryView: UIView!
    @IBOutlet weak var GaleryImagesView: UIImageView!
    @IBOutlet weak var ImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "GALARY"
        navigationItem.prompt = "Welcome"
        let tapGuster = UITapGestureRecognizer(target: self, action: #selector(ToNextImageByTapping))
        ImageView.addGestureRecognizer(tapGuster)
        let startedImage = UIImage(named: imagesName[currentImageIndex])
        ImageView.image = startedImage
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        ToNextImage()
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        toBackImage()
    }
    
    func ToNextImage() {
        if currentImageIndex == 3 {
            UIView.animate(withDuration: 0.9) {
                self.VC.setViewBack(view: self.mainGalaryView, hidden: false)
                self.GaleryImagesView.image = UIImage(named: self.imagesName[0])
                self.currentImageIndex = 0
            }
        }
        else {
            UIView.animate(withDuration: 0.9) {
                self.VC.setViewBack(view: self.mainGalaryView, hidden: false)
                self.GaleryImagesView.image = UIImage(named: self.imagesName[self.currentImageIndex+1])
                self.currentImageIndex += 1
            }
        }
    }
    func toBackImage() {
        if currentImageIndex == 0 {
            UIView.animate(withDuration: 0.9) {
                self.VC.setView(view: self.mainGalaryView, hidden: false)
                self.GaleryImagesView.image = UIImage(named: self.imagesName[3])
                self.currentImageIndex = 3
            }
        }
        else {
            UIView.animate(withDuration: 0.9) {
                self.VC.setView(view: self.mainGalaryView, hidden: false)
                self.GaleryImagesView.image = UIImage(named: self.imagesName[self.currentImageIndex-1])
                self.currentImageIndex -= 1
            }
        }
    }
    
    @objc func ToNextImageByTapping(){
        ToNextImage()
    }

}
