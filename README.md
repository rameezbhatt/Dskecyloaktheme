# Custom Keycloak Theme

A custom login theme for Keycloak identity and access management platform.

## Description

This is a custom theme that modifies the default Keycloak login interface.

## Installation

1. Mount the theme directory to your Keycloak container:
   ```bash
   -v /path/to/theme:/opt/keycloak/themes/ds/login
   ```

2. The container needs to be run as root user:
   ```bash
   --user root
   ```

## Usage

1. Log in to your Keycloak Admin Console
2. Go to Realm Settings
3. Switch to the Themes tab
4. Select "ds" from the Login Theme dropdown
5. Click Save

## Structure

