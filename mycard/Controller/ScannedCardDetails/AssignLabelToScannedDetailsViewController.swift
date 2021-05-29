//
//  AssignLabelToScannedDetailsViewController.swift
//  mycard
//
//  Created by Joseph Maclean Arhin on 5/5/21.
//

import UIKit

class AssignLabelToScannedDetailsViewController: UIViewController {

    var viewModel: ReviewScannedCardDetailsViewModel!
    var detailToChange: (name: String, index: Int)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

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

    @IBAction func phoneNumberPressed(_ sender: UIButton) {
        if let detail = detailToChange {
            viewModel.changeToPhoneNumber(name: detail.name, index: detail.index, type: sender.currentTitle!)
        } else {
            viewModel.setPhoneNumber(type: sender.currentTitle!)
        }
        detailToChange = nil
        dismiss(animated: true)
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

//    TODO: add social media
    @IBAction func socialMediaPressed(_ sender: Any) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}