# Deployable Radio Extenders

## Description
Provides units with the variable `karma_canDeployRadioExtender` set to `true` to deploy radio extenders anywhere via the action menu.
Deployed radio extenders can then be repacked and deployed again.
Only one radio extender is allowed to be deployed at a time per engineer.

## Enabling radio extender deployment for a unit
To allow a unit to deploy a radio extender, add the following to their init via the editor:
```sqf
this setVariable ["karma_canDeployRadioExtender", true];
```
