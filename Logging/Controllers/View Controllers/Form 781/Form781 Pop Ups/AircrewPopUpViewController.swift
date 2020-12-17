//
//  AircrewPopUpViewController.swift
//  Logging
//
//  Created by Bethany Morris on 12/15/20.
//  Copyright © 2020 Christian Brechbuhl. All rights reserved.
//

import UIKit

protocol AircrewPopUpViewControllerDelegate: class {
    func closeAircrewPopUp()
}

class AircrewPopUpViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var ssn: UITextField!
    @IBOutlet weak var flightAuthDutyCode: UITextField!
    @IBOutlet weak var flyingOrigin: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: AircrewPopUpViewControllerDelegate?
    var isEditingMember = false
    var crewMemberToEdit: CrewMember?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // MARK: - Methods
    
    func setUpViews() {
        lastName.delegate = self
        firstName.delegate = self
        ssn.delegate = self
        flightAuthDutyCode.delegate = self
        flyingOrigin.delegate = self
    }
    
    func presentAlertIfInputError() {
        #warning("Why don't we post the error is the text field is undefined?")
        guard let lastName = lastName.text else {
            NSLog("ERROR: AircrewViewController: presentAlertIfInputError() - optional text is nil - lastName")
            return
        }
        guard let firstName = firstName.text else {
            NSLog("ERROR: AircrewViewController: presentAlertIfInputError() - optional text is nil - firstName")
            return
        }
        guard let ssn = ssn.text else {
            NSLog("ERROR: AircrewViewController: presentAlertIfInputError() - optional text is nil - ssn")
            return
        }
        guard let flightAuthDutyCode = flightAuthDutyCode.text else {
            NSLog("ERROR: AircrewViewController: presentAlertIfInputError() - optional text is nil - flightAuthDutyCode")
            return
        }
        guard let flyingOrigin = flyingOrigin.text else {
            NSLog("ERROR: AircrewViewController: presentAlertIfInputError() - optional text is nil - flyingOrigin")
            return
        }

        if isEditingMember {
            guard let crewMember = self.crewMemberToEdit else {
                NSLog("ERROR: AircrewViewController: presentAlertIfInputError() - isEditingMember = true, but crewMemberToEdit undefined.")
                return
            }

            Alerts.showInputErrorAlert(on: self) { (_) in

                Form781Controller.shared.updateCrewMemberInfo(crewMember: crewMember, lastName: lastName, firstName: firstName, ssnLast4: ssn, flightAuthDutyCode: flightAuthDutyCode, flyingOrigin: flyingOrigin)

                self.closePopUp()
            }
        } else {

            guard let form = Form781Controller.shared.getCurrentForm() else {
                NSLog("WARNING: AircrewViewController: presentAlertIfInputError() - isEditingMember = false, but no current form.")
                return
            }

            Alerts.showInputErrorAlert(on: self) { (_) in

                CrewMemberController.create(form: form, lastName: lastName, firstName: firstName, ssnLast4: ssn, flightAuthDutyCode: flightAuthDutyCode, flyingOrigin: flyingOrigin)

                self.closePopUp()
            }
        }
    }

    func highlight() {
        lastName.text == "" ? Helper.highlightRed(textField: lastName) : Helper.unhighlight(textField: lastName)
        firstName.text == "" ? Helper.highlightRed(textField: firstName) : Helper.unhighlight(textField: firstName)
        ssn.text == "" ? Helper.highlightRed(textField: ssn) : Helper.unhighlight(textField: ssn)
        flightAuthDutyCode.text == "" ? Helper.highlightRed(textField: flightAuthDutyCode) : Helper.unhighlight(textField: flightAuthDutyCode)
        flyingOrigin.text == "" ? Helper.highlightRed(textField: flyingOrigin) : Helper.unhighlight(textField: flyingOrigin)
    }

    func unhighlight() {
        Helper.unhighlight(textField: lastName)
        Helper.unhighlight(textField: firstName)
        Helper.unhighlight(textField: ssn)
        Helper.unhighlight(textField: flightAuthDutyCode)
        Helper.unhighlight(textField: flyingOrigin)
    }

    func clearFields() {
        lastName.text = nil
        firstName.text = nil
        ssn.text = nil
        flightAuthDutyCode.text = nil
        flyingOrigin.text = nil
    }

    func populateFields(crewMember: CrewMember) {
        lastName.text = crewMember.lastName
        firstName.text = crewMember.firstName
        ssn.text = crewMember.ssnLast4
        flightAuthDutyCode.text = crewMember.flightAuthDutyCode
        flyingOrigin.text = crewMember.flyingOrigin
    }

    func closePopUp() {
        isEditingMember = false
        clearFields()
        saveButton.setTitle("+ ADD NEW CREW", for: .normal)
        unhighlight()
        delegate?.closeAircrewPopUp()
    }
    
    // MARK: - Actions
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        closePopUp()
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        highlight()
        #warning("Should we split this up? If *.text is nil this is some other error. If the item is empty, we handle it with presentAlertIfInputError().")
        guard let lastName = lastName.text, !lastName.isEmpty,
              let firstName = firstName.text, !firstName.isEmpty,
              let ssn = ssn.text, !ssn.isEmpty,
              let flyingOrigin = flyingOrigin.text, !flyingOrigin.isEmpty,
              let flightAuthDutyCode = flightAuthDutyCode.text, !flightAuthDutyCode.isEmpty
        else {
            return self.presentAlertIfInputError()
        }

        if isEditingMember {
            guard let crewMember = self.crewMemberToEdit else {
                NSLog("ERROR: AircrewViewController: saveButtonTapped() - isEditingMember = true, but crewMemberToEdit undefined.")
                return
            }

            Form781Controller.shared.updateCrewMemberInfo(crewMember: crewMember, lastName: lastName, firstName: firstName, ssnLast4: ssn, flightAuthDutyCode: flightAuthDutyCode, flyingOrigin: flyingOrigin)

            closePopUp()

        } else {

            guard let form = Form781Controller.shared.getCurrentForm() else {
                NSLog("WARNING: AircrewViewController: saveButtonTapped() - isEditingMember = false, but no current form.")
                return
            }

            CrewMemberController.create(form: form, lastName: lastName, firstName: firstName, ssnLast4: ssn, flightAuthDutyCode: flightAuthDutyCode, flyingOrigin: flyingOrigin)

            closePopUp()
        }
    }

    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        ssn.resignFirstResponder()
        flyingOrigin.resignFirstResponder()
        flightAuthDutyCode.resignFirstResponder()
    }
    
} //End

// MARK: - UITextField Delegate

extension AircrewPopUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
} //End

// MARK: - Delegates

extension AircrewPopUpViewController: MainViewControllerAircrewPopUpDelegate {
    
    func editAircrewButtonTapped(crewMember: CrewMember) {
        populateFields(crewMember: crewMember)
        isEditingMember = true
        crewMemberToEdit = crewMember
        saveButton.setTitle("SAVE", for: .normal)
    }
    
} //End