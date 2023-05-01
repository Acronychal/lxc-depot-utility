## Proxmox LXC Deployment Utility
This utility helps create LXC containers with minimal user input. 

When script runs. It'll search for available distribution templates locaed in the /var/lib/vz/template/cache directory in Proxmox VE. 

The utility prompts then the user to select the distribution file to be used from a list.

The user is prompted to select from three diferent predefined container sizes.

- SM = Small LXC container with 2 cores and 2 gb of RAM. 
- MD = Medium LXC container with 4 cores and 4 gb of RAM.
- LG = Large LXC conter with 8 cores and 8 gb of RAM. 

Finally, it prompts the user for general information to complete the build.

## To do:
- Clean up menu options
- Prompts using dialog
- Review for improvements
- Add running .gif to README 