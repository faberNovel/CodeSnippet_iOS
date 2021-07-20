# Xcode Snippets

## #FN - UIView inits override with setup

Inits override for UIView with a setup method

**Keyword: setupview**

<details>
<summary>Snippet code</summary>

```swift
// MARK: - Life cycle

override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
}

required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
}

// MARK: - Private

private func setup() {
    <#code#>
}
```
</details>

## #FN - guard let self = self

A guard to get a strong self

**Keyword: gself**

<details>
<summary>Snippet code</summary>

```swift
guard let self = self else { return }
```
</details>

## #FN - Mark

A section indicator comment

**Keyword: m**

<details>
<summary>Snippet code</summary>

```swift
// MARK: - <#comment#>
```
</details>

## #FN - Private function

A private function

**Keyword: pfunc**

<details>
<summary>Snippet code</summary>

```swift
private func <#funcName#>() {
    <#code#>
}
```
</details>

## #FN - Autolayout pin

The verbose code to pin a view with autolayout

<details>
<summary>Snippet code</summary>

```swift
<#SubView#>.translatesAutoresizingMaskIntoConstraints = false
<#SubView#>.topAnchor.constraint(equalTo: <#SubViewContainerView#>.topAnchor).isActive = true
<#SubView#>.bottomAnchor.constraint(equalTo: <#SubViewContainerView#>.bottomAnchor).isActive = true
<#SubView#>.leadingAnchor.constraint(equalTo: <#SubViewContainerView#>.leadingAnchor).isActive = true
<#SubView#>.trailingAnchor.constraint(equalTo: <#SubViewContainerView#>.trailingAnchor).isActive = true
```
</details>

## #FN - MARK Private

A private indicator comment

**Keyword: mp**

<details>
<summary>Snippet code</summary>

```swift
// MARK: - Private
```
</details>

## #FN - Swiftlint ignore comment

A comment to disable locally swiftlint rules

**Keyword: swiftlint**

<details>
<summary>Snippet code</summary>

```swift
// swiftlint:disable:<#this/next#> <#disabled_warning#>
```
</details>

## #FN - MARK Public

A public indicator comment

**Keyword: mpu**

<details>
<summary>Snippet code</summary>

```swift
// MARK: - Public
```
</details>

## #FN - Constants

A constants enum snippet following Fabernovel coding style

**Keyword: cst**

<details>
<summary>Snippet code</summary>

```swift
private enum Constants {
    static let <#constantName#>: <#constantType#> = <#constantValue#>
}
```
</details>

## #FN - private let

A private constant

**Keyword: plet**

<details>
<summary>Snippet code</summary>

```swift
private let <#name#> = <#value#>
```
</details>

## #FN - Private var

A private variable

**Keyword: pvar**

<details>
<summary>Snippet code</summary>

```swift
private var <#variable#>: <#Type#>
```
</details>

