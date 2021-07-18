//
//  AssignLabelToScannedDetailsViewController.swift
//  mycard
//
//  Created by Joseph Maclean Arhin on 5/5/21.
//

import UIKit

class AssignLabelToScannedDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var mobileNumberButton: UIButton!
    @IBOutlet weak var homeNumberButton: UIButton!
    @IBOutlet weak var workNumberButton: UIButton!
    @IBOutlet weak var otherNumberButton: UIButton!
    @IBOutlet weak var personalEmailButton: UIButton!
    @IBOutlet weak var workEmailButton: UIButton!
    @IBOutlet weak var otherEmailButton: UIButton!
    @IBOutlet weak var emailStackView: UIStackView!
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var phoneDropDownButton: UIButton!
    @IBOutlet weak var emailDropDownButton: UIButton!
    var phoneStackViewLength = 0
    var emailStackViewLength = 0

    // MARK: - properties
    var viewModel: ReviewScannedCardDetailsViewModel!
    var detailToChange: (name: String, index: Int)?

    // MARK: - viewcontroller methods
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

    override func viewWillAppear(_ animated: Bool) {
        if let detailToChange = detailToChange {
            self.detailTitleLabel.text = detailToChange.0
            self.detailLabel.text = viewModel.findDetail(
                name: detailToChange.0, index: detailToChange.1
            )
        } else {
            self.detailTitleLabel.text = "unlabelled"
            self.detailLabel.text = viewModel.findDetail(index: viewModel.currentUnlabelledDetailIndex ?? 0)
        }
    }

    // MARK: - actions
    @IBAction func fullNamePressed(_ sender: UIButton) {
        if let detail = detailToChange {
            viewModel.changeToFullName(name: detail.name, index: detail.index)
        } else {
            viewModel.untagLabelledDetail(name: "full name", index: 0)
            viewModel.setFullName()
        }
        detailToChange = nil
        dismiss(animated: true)

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
        if let detail = detailToChange {
            viewModel.changeToPhoneNumber(name: detail.name, index: detail.index, type: sender.currentTitle!)
        } else {
            viewModel.setPhoneNumber(type: sender.currentTitle!)
        }
        detailToChange = nil
        dismiss(animated: true)
    }

    @IBAction func emailDropDownPressed(_ sender: Any) {
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
    @IBAction func emailPressed(_ sender: UIButton) {
        if let detail = detailToChange {
            viewModel.changeToEmail(name: detail.name, index: detail.index, type: sender.currentTitle!)
        } else {
            viewModel.setEmail(type: sender.currentTitle!)
        }
        detailToChange = nil
        dismiss(animated: true)
    }

    @IBAction func businessInfoPressed(_ sender: UIButton) {
        if let detail = detailToChange {
            viewModel.changeToBusinessInfo(name: detail.name, index: detail.index, type: sender.currentTitle!)
        } else {
            viewModel.untagLabelledDetail(name: sender.currentTitle!, index: 0)
            viewModel.setBusinessInfo(type: sender.currentTitle!)
        }
        detailToChange = nil
        dismiss(animated: true)
    }

    @IBAction func socialMediaPressed(_ sender: UIButton) {
        if let detail = detailToChange {
            viewModel.changeToSocialMedia(name: detail.name, index: detail.index, type: sender.currentTitle!)
        } else {
            viewModel.untagLabelledDetail(name: sender.currentTitle!, index: 0)
            viewModel.setSocialMedia(type: SocialMediaType.init(rawValue: sender.currentTitle!)!)
        }
        detailToChange = nil
        dismiss(animated: true)
    }

}
