# attachmentgenie-example

[![](https://img.shields.io/puppetforge/pdk-version/attachmentgenie/example.svg?style=popout)](https://forge.puppetlabs.com/attachmentgenie/example)
[![](https://img.shields.io/puppetforge/v/attachmentgenie/example.svg?style=popout)](https://forge.puppetlabs.com/attachmentgenie/example)
[![](https://img.shields.io/puppetforge/dt/attachmentgenie/example.svg?style=popout)](https://forge.puppetlabs.com/attachmentgenie/example)
[![Spec Tests](https://github.com/attachmentgenie/attachmentgenie-example/actions/workflows/spec.yml/badge.svg)](https://github.com/attachmentgenie/attachmentgenie-example/actions/workflows/spec.yml)
[![License](https://img.shields.io/github/license/attachmentgenie/attachmentgenie-example?stype=popout)](https://github.com/attachmentgenie/attachmentgenie-example/blob/master/LICENSE)

Deploy and configure attachmentgenie's example on a node.

- [Description](#description)
- [Usage](#usage)
- [Reference](#reference)
- [Changelog](#changelog)
- [Limitations](#limitations)
- [Development](#development)

## Description

This project serves as my starter project

## Usage

All options and configuration can be done through interacting with the parameters
on the main example class.
These are now documented via [Puppet Strings](https://github.com/puppetlabs/puppet-strings)

You can view example usage in [REFERENCE](REFERENCE.md).

## Reference

See [REFERENCE](REFERENCE.md).

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

### Running tests

This project contains tests for both rspec-puppet and litmus to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart:

```
pdk bundle install
pdk bundle exec rake 'litmus:provision_list[puppet6]'
pdk bundle exec rake 'litmus:install_agent[puppet6]'
pdk bundle exec rake litmus:install_module
pdk bundle exec rake litmus:acceptance:parallel
pdk bundle exec rake litmus:tear_down
