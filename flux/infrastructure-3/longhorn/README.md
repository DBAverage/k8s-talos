# Notes

- add disk
- format as xfs or ext4
- mount to /storage directory
- grant permissions: sudo chown -R 1000:1000 /storage
- add through longhorn UI; haven't found crd to do this


- Commonly user and group 1000 is used for permissions within a pod. For this to work smoothly, granting this user and group permissions on the underlying disk is critical.

