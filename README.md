# Avro Typescript GitHub Actions
This repository houses GitHub actions to generate NPM Packages out of Avro schema files and publish them.


## How to use:
Please have a look at [avro-nuget-sandbox repository](https://github.com/EducationPerfect/avro-nuget-sandbox) as an example.


## Contributing:
- After change the code in any action, you can use `make pack-build` to build the container on your local dev environment.
- Running `make pack-run` will generate the code and build it for publising as package and store it in the `artifacts` folder.
- There are some other targets in the [Makefile](./Makefile) which could help you for debugging. Please remember the Makefile requires `avro-nuget-sandbox` as a sibling repository on your local env.
- When you are happy with your changes commit the code and push to github.
- Finally create a new release by choosing a proper tag.
- You can test the actions on GitHub workflow from [avro-nuget-sandbox]. Please remember to update the actions versions [here](https://github.com/EducationPerfect/avro-nuget-sandbox/blob/main/.github/workflows/ci.yaml) to the latest release version.


## Actions
---
## Pack
The `pack` action generate an NPM package out of the given Avro schema files and has the following inputs:

#### Inputs

#### `package-name`

**Required** The name of the NPM package.

#### `package-version`

**Required** The version of the NPM package.

#### `avro-folder`

**Required** The path to the folder containing Avro schema files.

#### `output-path`

**Required** The path to the put generated package at.

#### `company-name`

The name of the company publishing the package. The default value is `Education Perfect`.

#### `authors`

The authors of the package. The default value is `Team VOID`.

### Example usage

```yaml
uses: EducationPerfect/avro-typescript/pack@v1.0.1
with:
  package-name: 'AwesomePackage'
  package-version: 1.0.0
  avro-dir-path: ./avro
  output-path: ./packages
  authors: 'Team Void'
```

---
## Publish
The `public` action publish the given NPM packages to s given source and has the following inputs:

### Inputs

#### `artifact-path`

**Required** The path where the built files are located

#### `api-key`

**Required** The API Key for the NPM registry.

### Example usage

```yaml
uses: EducationPerfect/avro-typescript/publish@v1.0.1
with:
  artifact-path: ./packages
  api-key: ${{ secrets.FED_EP_NPM_TOKEN_WRITE }}
```
