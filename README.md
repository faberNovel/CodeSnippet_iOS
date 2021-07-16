#  CodeSnippet

Code snippets are a way to share iOS practices and facilitate their integration inside Xcode projects.

## Browsing snippets

You can browse code snippets in the [CodeSnippet](https://github.com/faberNovel/CodeSnippet_iOS/tree/master/CodeSnippet.md) folder. Each snippet resides in its dedicated folder and provides a `README` file.

## Integrating code snippets in Xcode

### As Xcode templates

To facilitate their integration inside Xcode, each [code snippet](https://github.com/faberNovel/CodeSnippet_iOS/tree/master/CodeSnippet.md) is associated to s Xcode template.

To install the snippet templates in your machine, install [xcresource](https://github.com/faberNovel/xcresource-cli) and run `xcresource template install`. Run the command again to update them.

The snippet templates will be available inside Xcode anytime you create a new file (File > New > File or ⌘ + N).

> Once integrated, a snippet can be modified as much as you want. It should be tested and understood by you.

### As Xcode codesnippets

[XCSnippet](https://github.com/faberNovel/CodeSnippet_iOS/tree/master/XcodeSnippet.md) contains snippets that can be added to in the [Xcode code Snippets library](https://sarunw.com/posts/how-to-create-code-snippets-in-xcode/).

Run `xcresource snippet install` to install them.

## Contribute

See the [contribution guide](https://github.com/faberNovel/CodeSnippet_iOS/tree/master/Contributing.md).
