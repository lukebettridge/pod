//
//  StoreManager.swift
//  Pod
//
//  Created by Luke Bettridge on 07/02/2021.
//

import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    var request: SKProductsRequest!
    
    @Published var products = [SKProduct]()
    @Published var transactionState: SKPaymentTransactionState?
    
    let productIDs = [
        "uk.co.lukebettridge.pod.plus"
    ]
    
    override init() {
        super.init()
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func hasProduct(_ identifier: String? = nil) -> Bool {
        UserDefaults.standard.bool(forKey: identifier ?? productIDs[0])
    }
    
    func purchaseProduct(_ product: SKProduct? = nil) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product ?? self.products[0])
            SKPaymentQueue.default().add(payment)
        }
    }
    
    func restoreProducts() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    internal func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if !response.products.isEmpty {
            for fetchedProduct in response.products {
                DispatchQueue.main.async {
                    self.products.append(fetchedProduct)
                }
            }
        }
    }
    
    internal func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .purchased
            case .restored:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .restored
            case .failed, .deferred:
                print("Payment Queue Error: \(String(describing: transaction.error))")
                    queue.finishTransaction(transaction)
                    transactionState = .failed
                    default:
                    queue.finishTransaction(transaction)
            }
        }
    }
    
}
