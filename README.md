# SuperHub

SuperHub is an iPhone app with two modes. Family Hub is the Capacitor app. Bot Life is the SwiftUI app. Each mode keeps its own settings.

The originals are submodules under `vendor/`. Do not commit inside them.

## Build

```sh
git submodule update --init --recursive
cd vendor/family-hub && pnpm install && pnpm --filter @workspace/family-hub run build:mobile && cd ../..
make project
make test
```

`make test` builds SuperHub and runs the unit tests and the mode-switch UI test on the iPhone 17 Pro simulator.

Pins at the time this app was assembled are `vendor/bot-life` `3753c895fe0abbdcc95f9cd94576865b05fad9b2` and `vendor/family-hub` `8480ffc63320bfd3bab5413f8acb6988b2ced5b5`.
