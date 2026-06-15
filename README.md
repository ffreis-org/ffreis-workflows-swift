# ffreis-workflows-swift

<!-- ffreis-badges:start -->
[![CI](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/FelipeFuhr/ffreis-badges/main/badges/ffreis-workflows-swift/ci.json)](https://github.com/FelipeFuhr/ffreis-workflows-swift/actions) [![Latest version](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/FelipeFuhr/ffreis-badges/main/badges/ffreis-workflows-swift/version.json)](https://github.com/FelipeFuhr/ffreis-workflows-swift/releases) [![License](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/FelipeFuhr/ffreis-badges/main/badges/ffreis-workflows-swift/license.json)](https://github.com/FelipeFuhr/ffreis-workflows-swift/blob/main/LICENSE)
<!-- ffreis-badges:end -->

Reusable GitHub Actions workflows for Swift / iOS projects. **Lint runs on ubuntu (cheap); only the
build/test job runs on macOS — and it is `workflow_dispatch`-gated by cost guard.**

## Workflows

| Workflow | Runner | Trigger discipline | Purpose |
|---|---|---|---|
| `swift-lint.yml` | ubuntu (container) | push/PR ok | SwiftLint |
| `swift-build.yml` | **macOS** | **`workflow_dispatch` only** | SPM or xcodebuild build + test |

## Usage (iOS consumer, e.g. petlook-mobile)

```yaml
# lint.yml — cheap, on push/PR
jobs:
  lint:
    uses: FelipeFuhr/ffreis-workflows-swift/.github/workflows/swift-lint.yml@<sha> # v0.1.0
    with:
      working-directory: ios

# ios-build.yml — on: workflow_dispatch ONLY (never push/PR — macOS bills 10x)
jobs:
  build:
    uses: FelipeFuhr/ffreis-workflows-swift/.github/workflows/swift-build.yml@<sha> # v0.1.0
    with:
      working-directory: ios
      build-tool: xcodebuild
      scheme: PetLook
```

Pin to a release tag's commit SHA (Renovate keeps it current). See [AGENTS.md](AGENTS.md).
