# Update v1.1.4 - patching reprojection specifications in mt_to_terra()

New release, updating a faulty reprojection setting in v1.1.3 in the
mt_to_terra() function, as highlighted by a user. This fixes the issue,
no other changes were made.

I have read and agree to the the CRAN policies at
http://cran.r-project.org/web/packages/policies.html

## test environments, local, CI and r-hub

- Ubuntu 22.04 install on R 4.2.2
- Ubuntu 20.04 on github actions (devel / release)
- Checks for macOS and Windows on github actions
- codecove.io code coverage at ~88%

## local / Travis CI R CMD check results

0 errors | 0 warnings | 0 notes
