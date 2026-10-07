# Drive the SuperHub simulator

SuperHub has no browser control skill. Drive it with `xcodebuild test` and `xcrun simctl io booted screenshot`.

1. `git submodule update --init --recursive`
2. `cd vendor/family-hub && pnpm install && pnpm --filter @workspace/family-hub run build:mobile`
3. `make project`
4. Boot the iPhone 17 Pro simulator on OS 26.5.
5. `make test`

A Linux VM cannot run this. Fail the lane and rerun the same commands on a Mac.
