# Agent Context — ffreis-workflows-swift

Reusable GitHub Actions workflow library for **Swift / iOS (SwiftPM + xcodebuild)** projects.
Consumed by `petlook-mobile` (`ios/`). Sibling of `ffreis-workflows-go`, `-kotlin`, `-general`.

## Rules (mandatory)

1. **macOS COST GUARD — the single most important rule.** macOS runners bill 10x. `swift-build.yml`
   (the only macOS workflow) is `workflow_call`-only; **consumers MUST invoke it solely via
   `workflow_dispatch`** (or a schedule), never push/PR. This repo's own `ci.yml` gates
   `build-test-macos` to `workflow_dispatch`/`schedule`; push/PR run only the ubuntu `swift-lint`.
   Never add push/PR triggers that reach a macOS job.
2. **Lint runs on ubuntu.** `swift-lint.yml` runs SwiftLint in a container on `ubuntu-latest` —
   linting is source-level and needs no macOS. Keep it that way.
3. **Reusable workflows are `on: workflow_call` only**; **no `concurrency:`** (caller-controlled);
   per-job `permissions`; `timeout-minutes` on every job.
4. **harden-runner is Linux-only** — include it on the ubuntu workflows, omit it on the macOS
   `swift-build` job (it is unsupported on macOS).
5. **Draft-skip** via `run_on_draft` + the standard `if:` on the ubuntu workflows.
6. **Third-party action SHAs are Renovate-managed**; the SwiftLint container tag is the docker
   manager's concern (`swiftlint-image` input).
7. **Route inputs through `env:`** in `run:` steps (no `${{ inputs.* }}` in shell).
8. **Every workflow exercised in `ci.yml`** against `examples/hello/` (an SPM package, built via
   the `spm` path; the `xcodebuild` path is exercised by the petlook-mobile consumer).

## Workflows

- `swift-lint.yml` — SwiftLint (ubuntu container). Cheap.
- `swift-build.yml` — macOS build+test in ONE job (one billed macOS job, not two). Supports
  `build-tool: spm` (the example) and `build-tool: xcodebuild` (apps; runs `xcodegen generate`
  then unsigned simulator build/test).

## Versioning

release-please (`release-type: simple`); consumers pin a tag's commit SHA with `# vX.Y.Z`.
Security delegated to `ffreis-workflows-general` (`general-security-fs`, `general-codeql` with
`languages: swift`).

## Keeping this file current

If you add a workflow or change an input contract, update this file and `ci.yml` in the same PR.
Never relax the macOS cost guard.
