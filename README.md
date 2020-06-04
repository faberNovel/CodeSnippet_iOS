#  CodeSnippet

Code snippets are a way to share iOS practices and facilitate their integration inside Xcode projects.

## Usage

### Browse snippets

You can browse code snippets in the [CodeSnippet](https://github.com/faberNovel/CodeSnippet_iOS/tree/master/CodeSnippet) folder. Each snippet resides in its dedicated folder and provides a `README` file.

### Use snippets in Xcode

To facilitate their integration inside Xcode, each snippet is associated to a Xcode template.

To install the snippet templates in your machine, install [xctemplate](https://github.com/faberNovel/xctemplate-cli) and run `xctemplate install`. Run the command again to update them.

The snippet templates will be available inside Xcode anytime you create a new file (File > New > File or ⌘ + N).

> Once integrated, a snippet can be modified as much as you want. It should be tested and understood by you.

## Contribute

Clone this repository to get started and create your feature branch.

### Guide

**1. Create agnostic snippets**

A snippet can be used and edited by anyone. We should avoid snippet duplications as much as possible. Do not integrate too much of your own coding style in the snippet.

**2. Code that you keep copy/pasting among projects is a good candidate**

The main goal of snippet is to share good practices and centralize them.

**3. Consider creating a library before a snippet**

The difference between snippets and librairies can be slight, especially with the Xcode integration feature.

Here are some key differences:

- A snippet does not need to be isolated inside a project. It evolves with It. Sometime it's hard to create a library that can support all its possible usages. The segmented view controller is a good example: we need too many customizations to make a viable library out of it.
- A snippet should not require unit tests. It should be lightweight and mainly boilerplate. If you need to repeatedly isolate a complex algorithm or a functionality, create a library instead.
- A snippet can be fulfillable. Some parts of it can be left empty and fulfilled once integrated.

**4. Consider ADUtils before a snippet**

If your code is generic and helpful for everyone, add it to [ADUtils](https://github.com/applidium/ADUtils) instead.

### Create a Xcode template

Open `CodeSnippet.xcworkspace`.

The easiest way to create a snippet, it's to make its Xcode template first. You will add your snippet in its folder once you are done.

First, copy/paste an existing `.xctemplate` folder. They are located inside the `XCTemplate` folder.

Modify or add as many files as you want inside your template folder. Don't forget to fulfill the `TemplateInfo.plist` file accordingly.

Do not hesitate to use the Xcode template variables and others Xcode tricks (`___FILEBASENAME___` etc).

> Make sure your templates files are not added to one of the Xcode project targets.

### Create your snippet

To install your snippet template to Xcode, commit your code and install it locally:

`xctemplate install --url path/to/the/repository --branch yourBranch`

Your template should now appear in Xcode (File > New > File).

Create the snippet folder and create your code snippet inside it using the snippet template. Do not forget to provide a `README` file.

> Your code snippet should compile! Add the snippet dependencies to the project if needed.

### Publish your snippet

Create a PR once you are done. Thanks for contributing 😊

> You must be in the Fabernovel Github team for contributing.

## Under the hood

This tool relies on 3 github projects :

1. [https://github.com/faberNovel/homebrew-formulae](https://github.com/faberNovel/homebrew-formulae) : Fabernovel Homebrew Formulae
2. [https://github.com/faberNovel/xctemplate-cli](https://github.com/faberNovel/xctemplate-cli) : the snippet installer
3. [https://github.com/faberNovel/CodeSnippet_iOS](https://github.com/faberNovel/CodeSnippet_iOS) : the place where your snippets live

We have the following dependencies : (1) depends on (2) which depends on (3)
