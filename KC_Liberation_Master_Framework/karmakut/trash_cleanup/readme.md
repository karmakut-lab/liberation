# Trash Cleanup

## Description
Removes trash/dropped equipment on the ground from players to improve performance.

## Technical Details
When a player drops items on the ground, it will send a message to the server
about the resulting item clutter. The server will then clear all clutter that's 
older than a specific age, defined by `karma_trashCleanup_shared_trashRemovalThresholdInSeconds`.