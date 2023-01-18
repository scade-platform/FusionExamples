import FusionPayments
import ScadeKit

class MainPageAdapter: SCDLatticePageAdapter {

  var paymentManager: FusionPaymentsManager?

  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)

    self.button.onClick { [weak self] _ in
      let pNetworks: [PaymentNetwork] = [PaymentNetwork.amex, .visa, .masterCard]

      let paymentSummaryItem: PaymentSummaryItem = PaymentSummaryItem(
        label: "SomeLabelForShopping", amount: 3.3)

      let countries: Set<String> = ["US", "UK"]

      let paymentRequest: PaymentRequest = PaymentRequest(
        merchantIdentifier: "merchant.com.vedant.fusionpayments", countryCode: "US",
        currencyCode: "USD", supportedNetworks: pNetworks,
        paymentSummaryItem: paymentSummaryItem, supportedCountries: countries)

      self?.paymentManager = FusionPaymentsManager(paymentRequest: paymentRequest)

      self?.paymentManager?.initiatePayment(
        paymentRequest: paymentRequest,
        paymentStatus: { (status: PaymentStatus, error: PaymentError?) in
          print(status)
          print(error)

        },
        paymentSheetViewState: {
          viewState in
          print("viewed state")
          print(viewState)
        })

    }

  }
}
