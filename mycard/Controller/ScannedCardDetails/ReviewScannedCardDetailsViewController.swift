//
//  ReviewScannedCardDetailsViewController.swift
//  mycard
//
//  Created by Joseph Maclean Arhin on 5/1/21.
//

import UIKit
import RxCocoa
import RxSwift

class ReviewScannedCardDetailsViewController: UIViewController {

// MARK: - Outlets
    @IBOutlet weak var labelledDetailsStackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var unlabelledDetailsStackViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var labelledDetailsStackView: LabelledScannedDetailsStackView!
    @IBOutlet weak var unlabelledDetailStackView: UnlabelledScannedDetailsStackView!
// MARK: - Variables

    var viewModel: ReviewScannedCardDetailsViewModel!
    var disposeBag = DisposeBag()
    var currentUnlabelledIndex: Int?
    var selectedDetailToChange: (name: String, index: Int)?
    var selectedDetailToEdit: (name: String, index: Int)?
    var selectedIndexToEdit: Int?
    var detailEditType: EditDetailViewController.DetailEditType?

// MARK: - ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        labelledDetailsStackView.delegate = self
        unlabelledDetailStackView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Review scanned details"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        labelledDetailsStackViewHeightConstraint?.isActive = false
        unlabelledDetailsStackViewHeightConstraint?.isActive = false
        viewModel.labelledScannedDetails.subscribe { [unowned self] contact in
            labelledDetailsStackView.configure(contact)
        }.disposed(by: disposeBag)

        viewModel.unlabelledScannedDetails.subscribe { [unowned self] details in
            unlabelledDetailStackView.configure(details: details)
        }.disposed(by: disposeBag)

    }

// MARK: - Actions

    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func createCardPressed(_ sender: Any) {

    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AssignLabelToScannedDetailsViewController {
            destination.viewModel = viewModel
            guard let detail = selectedDetailToChange else {return}
            destination.detailToChange = detail
            self.selectedDetailToChange = nil
        }
        if let destination = segue.destination as? SelectLabelViewController {
            destination.viewmodel = viewModel
        }
        if let destination = segue.destination as? EditDetailViewController {
            destination.viewmodel = viewModel
            destination.selectedDetailToEdit = self.selectedDetailToEdit
            destination.selectedIndexToEdit = self.selectedIndexToEdit
            destination.editType = self.detailEditType
        }
    }
}

extension ReviewScannedCardDetailsViewController: LabelledScannedDetailsDelegate {
    func untag(detail: (String, Int)) {
        viewModel.untagLabelledDetail(name: detail.0, index: detail.1)
    }

    func edit(detail: (String, Int)) {
        selectedDetailToEdit = detail
        detailEditType = .labelled
        performSegue(withIdentifier: K.Segues.reviewScannedDetailsToEditDetail, sender: self)
    }

    func swap(detail: (String, Int)) {
        self.selectedDetailToChange = detail
        performSegue(withIdentifier: K.Segues.reviewScannedDetailsToAssignLabel, sender: self)
    }

}

extension ReviewScannedCardDetailsViewController: UnlabelledScannedDetailsDelegate {
    func labelPressed(id: Int) {
        selectedIndexToEdit = id
        detailEditType = .unlabelled
        performSegue(withIdentifier: K.Segues.reviewScannedDetailsToEditDetail, sender: self)
    }

    func addLabel(id: Int) {
        viewModel.currentUnlabelledDetailIndex = id
        performSegue(withIdentifier: K.Segues.reviewScannedDetailsToAssignLabel, sender: self)
    }

    func duplicate(id: Int) {
        viewModel.duplicateDetail(at: id)
    }

    func remove(id: Int) {
        viewModel.deleteUnlabelledDetail(at: id)
    }

}
