//
//  LoginViewModel.swift
//  FaceIdProject
//
//  Created by Gizem on 17.04.2023.
//

import LocalAuthentication

protocol LoginViewModelDelegate: AnyObject {
    func success()
}

class LoginViewModel {

    private let context = LAContext()
    weak var delegate: LoginViewModelDelegate?

    func authenticateUser() {
        context.localizedCancelTitle = "Cancel"

        if canEvaluatePolicy() {
            let reason = "Access requires authentication"
            evaluatePolicy(with: .deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
        } else {
            handleBiometricError()
        }
    }

    private func canEvaluatePolicy() -> Bool {
        var error: NSError?
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)

        if let error = error {
            handleBiometricError(error: error)
        }

        return canEvaluate
    }

    private func evaluatePolicy(with policy: LAPolicy, localizedReason: String) {
        context.evaluatePolicy(policy, localizedReason: localizedReason) { [weak self] (isSuccess, error) in
            DispatchQueue.main.async {
                if isSuccess {
                    self?.delegate?.success()
                } else if let error = error as NSError? {
                    self?.handleBiometricError(error: error)
                }
            }
        }
    }

    private func handleBiometricError(error: NSError? = nil) {
        var errorMessage = "Face ID/Touch ID may not be configured"

        if let error = error, let laErrorCode = LAError.Code(rawValue: error.code) {
            switch laErrorCode {
            case .authenticationFailed:
                errorMessage = "There was a problem verifying your identity."
            case .userCancel:
                errorMessage = "You pressed cancel."
            case .userFallback:
                errorMessage = "You pressed password."
            case .biometryNotAvailable:
                errorMessage = "Face ID/Touch ID is not available."
            case .biometryNotEnrolled:
                errorMessage = "Face ID/Touch ID is not set up."
            case .biometryLockout:
                errorMessage = "Face ID/Touch ID is locked."
            default:
                break
            }
        }

        print(errorMessage)
    }
}
