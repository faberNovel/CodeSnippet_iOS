#  AlertViewModel

A view model base to display alert

```swift
class AlertPresenter {

    var display: AlertPresenting?

    func displayAlert() {
        let alert = AlertViewModel(
            title: "toto",
            message: "toto",
            style: .alert,
            actions: [
                .destructive("Destroy") { print("BOUM") },
                .cancel()
            ]
        )
        display?.present(alert)
    }
}

```
