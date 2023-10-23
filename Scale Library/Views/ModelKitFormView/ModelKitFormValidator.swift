//
//  ModelKitFormValidator.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 20/10/23.
//

import Foundation

struct ModelKitFormValidator {
    func validate(modelKit: ModelKit) throws {
        
        if modelKit.title.isEmpty {
            throw CreateValidatorError.emptyTitle
        }
        if modelKit.title.count > 40 {
            throw CreateValidatorError.titleTooLong
        }
        
        if modelKit.shortDescription.isEmpty {
            throw CreateValidatorError.emptyDescription
        }
        if modelKit.shortDescription.count > 80 {
            throw CreateValidatorError.descriptionTooLong
        }
        
        if modelKit.price.isLess(than: 0) {
            throw CreateValidatorError.priceIsNegative
        }
    }
}

extension ModelKitFormValidator {
    enum CreateValidatorError: LocalizedError {
        case emptyTitle
        case titleTooLong
        case emptyDescription
        case descriptionTooLong
        case priceIsNegative
    }
}

extension ModelKitFormValidator.CreateValidatorError {
    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "Title can't be empty"
        case .titleTooLong:
            return "Title can't be longer than 40 characters"
        case .emptyDescription:
            return "Description can't be empty"
        case .descriptionTooLong:
            return "Description can't be longer than 80 characters"
        case .priceIsNegative:
            return "Price can't be below $0"
        }
    }
}

// Types of handled errors
extension ModelKitFormValidator {
    enum FormError: LocalizedError {
        case validation(error: LocalizedError)
        case contextSaving(error: LocalizedError)
    }
}

extension ModelKitFormValidator.FormError {
    var errorDescription: String? {
        switch self {
        case .validation(let err),
                .contextSaving(let err):
            return err.errorDescription
        }
    }
}
