//
//  SelectLabelViewController.swift
//  mycard
//
//  Created by Joseph Maclean Arhin on 5/23/21.
//

import UIKit

class SelectLabelViewController: UIViewController {

// MARK: - Outlets
    @IBOutlet weak var mobileNumberButton: UIButton!
    @IBOutlet weak var homeNumberButton: UIButton!
    @IBOutlet weak var workNumberButton: UIButton!
    @IBOutlet weak var otherNumberButton: UIButton!
    @IBOutlet weak var personalEmailButton: UIButton!
    @IBOutlet weak var workEmailButton: UIButton!
    @IBOutlet weak var otherEmailButton: UIButton!
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var emailStackView: UIStackView!
    @IBOutlet weak var phoneDropDownButton: UIButton!
    @IBOutlet weak var emailDropDownButton: UIButton!
    var phoneStackViewLength = 0
    var emailStackViewLength = 0

// MARK: - variables
    var selectedLabel: (String, String) = (type: "", subType: "")
    var viewmodel: ReviewScannedCardDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneStackViewLength = phoneStackView.arrangedSubviews.count
        emailStackViewLength = emailStackView.arrangedSubviews.count
        for i in 1 ... phoneStackViewLength-1 {
            phoneStackView.arrangedSubviews[i].isHidden = true
            phoneStackView.arrangedSubviews[i].alpha = 0
        }
        for i in 1 ... emailStackViewLength-1 {
            emailStackView.arrangedSubviews[i].isHidden = true
            emailStackView.arrangedSubviews[i].alpha = 0
        }
    }

// MARK: - Actions

    @IBAction func fullNamePressed(_ sender: UIButton) {
        self.selectedLabel = (type: sender.currentTitle!, subType: "")
        performSegue(withIdentifier: K.Segues.selectLabelToAddDetail, sender: self)
    }

    @IBAction func phoneDropDownPressed(_ sender: Any) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {[self] in
                if phoneDropDownButton.transform == CGAffineTransform.identity {
                    phoneDropDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                } else {
                    phoneDropDownButton.transform = CGAffineTransform(rotationAngle: 0)
                }
                for i in 1 ..< phoneStackViewLength {
                    let view = phoneStackView.arrangedSubviews[i]
                    view.isHidden.toggle()
                    if i != 0 {
                        if view.alpha == 0 {
                            view.alpha = 1
                        } else {
                            view.alpha = 0
                        }
                    }
                }
            }
        }
    }

    @IBAction func phoneNumberPressed(_ sender: UIButton) {
        self.selectedLabel = (type: "Phone number", subType: sender.currentTitle!)
        performSegue(withIdentifier: K.Segues.selectLabelToAddDetail, sender: self)
    }

    @IBAction func mailDropDownPressed(_ sender: Any) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {[self] in
                if emailDropDownButton.transform == CGAffineTransform.identity {
                    emailDropDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                } else {
                    emailDropDownButton.transform = CGAffineTransform(rotationAngle: 0)
                }
                for i in 1 ..< emailStackViewLength {
                    let view = emailStackView.arrangedSubviews[i]
                    view.isHidden.toggle()
                    if i != 0 {
                        if view.alpha == 0 {
                            view.alpha = 1
                        } else {
                            view.alpha = 0
                        }
                    }
                }
            }
        }
    }

    @IBAction func emailAddressPressed(_ sender: UIButton) {
        self.selectedLabel = (type: "Email address", subType: sender.currentTitle!)

        performSegue(withIdentifier: K.Segues.selectLabelToAddDetail, sender: self)
    }

    @IBAction func businessInfoPressed(_ sender: UIButton) {
        self.selectedLabel = (type: sender.currentTitle!, subType: "")
        performSegue(withIdentifier: K.Segues.selectLabelToAddDetail, sender: self)
    }

    @IBAction func socialMediaPressed(_ sender: UIButton) {
        self.selectedLabel = (type: sender.currentTitle!, subType: "")
        performSegue(withIdentifier: K.Segues.selectLabelToAddDetail, sender: self)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddDetailViewController {
            destination.selectedLabel = self.selectedLabel
            destination.viewmodel = viewmodel
        }
    }

}
