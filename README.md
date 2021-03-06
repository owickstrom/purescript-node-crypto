# purescript-node-crypto

This library wraps the [Crypto](https://nodejs.org/api/crypto.html) library
in NodeJS in a PureScript API.

## Status

The current implementation is experimental and lacks bindings for many of the
functions in the Crypto library. I have just implemented the ones that I have
needed so far. If you want to add more bindings, please submit an issue and
then we can discuss a pull request.

## Build & Test

First install the dependencies.

```bash
bower i
```

You can then build the project using Pulp.

```bash
pulp build
```

The test suite uses [purescript-spec](https://github.com/owickstrom/purescript-spec)
and its [automatic spec discovery](https://github.com/owickstrom/purescript-spec-discovery).
Run the following command to run the test suite:

```bash
pulp test
```

## Documentation

API documentation is [published on Pursuit](http://pursuit.purescript.org/packages/purescript-node-crypto).

Many of the functions map directly to the functions in the NodeJS API, so it
is suggested to use https://nodejs.org/api/crypto.html as a primary
reference. I might, however, add some examples and documentation here later.

## Contributing

Use the GitHub Issues tracker to post bug reports and problems. Pull request
are welcome, but please discuss the changes before sending larger patches.
