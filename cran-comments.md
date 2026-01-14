Dear CRAN Team,

This is a small correction in the mt_to_terra() function, removing the
dependence on some old {sp} functionality. This is now replaced with {sf} and
{terra} equivalents. In addition, some redirecting urls were updated.
No other changes were made.

Kind regards,
Koen Hufkens

--- 

## test environments, local, CI and r-hub

- Ubuntu 22.04 install on R 4.5.2
- Ubuntu 22.04 on github actions (devel / release)
- checks for macOS and Windows on github actions
- codecove.io code coverage at ~89%

## local R CMD check results

0 errors | 0 warnings | 0 notes
