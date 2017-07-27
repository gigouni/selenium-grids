# Firefox before 48

Aim of this part: explain the problematic coming from building Docker images for Firefox before its 48 version.

## Getting started
### Explanations

When building Docker images of Firefox with recent versions (>48), it uses GeckoDriver. It wasn't true before this version. It was using the Marionette driver.