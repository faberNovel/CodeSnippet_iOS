#  RuntimeContext

A class to prevent reverse engineering attacks based on [WOASP](https://github.com/OWASP/owasp-mstg/blob/master/Document/0x06j-Testing-Resiliency-Against-Reverse-Engineering.md#checking-protocol-handlers).

```swift
RuntimeContext().satisfyOrCrash(.isSafe)
```
