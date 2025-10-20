[![codecov](https://codecov.io/gh/CruGlobal/keychain-password-store-ios/branch/main/graph/badge.svg)](https://codecov.io/gh/CruGlobal/keychain-password-store-ios)

Keychain Password Store
=======================

Implements Security Framework for storing passwords in a device keychain.

- [Publishing New Versions With GitHub Actions](#publishing-new-versions-with-github-actions)
- [Publishing New Versions Manually](#publishing-new-versions-manually)

### Publishing New Versions With GitHub Actions

Publishing new versions with GitHub Actions build workflow.

- Ensure a new version is set in the VERSION file.  This can be set manually or by manually running the Create Version workflow.

- Create a pull request on main and once merged into main GitHub actions will handle tagging the version from the VERSION file.

### Publishing New Versions Manually

Steps to publish new versions for Swift Package Manager. 

- Set the new version number in the VERSION file.

- Tag the main branch with the new version number and push the tag to origin.
