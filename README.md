# st

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with st](#setup)
    * [What st affects](#what-st-affects)
    * [Beginning with st](#beginning-with-st)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

Module to install the [st terminal emulator](http://st.suckless.org)

## Module Description

This module compiles and installs the
[st terminal emulator](http://st.suckless.org)
on a target node.

## Setup

### What st affects

* `st` executable at defined location.

### Beginning with st

```puppet
include st
```

## Usage

### I just want `st` installed

```puppet
include st
```

### I want to specify the version and location of `st`

```puppet
class { 'st':
  version => '0.4.1',
  prefix => '/opt/mysoftware',
}
```

## Reference

### Classes

* `st`: Installs the st binary

## Limitations

This module is known to work with the following operating system families:

 - Debian 8.2.0 or newer
