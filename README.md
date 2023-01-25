# BigBlueButton IP Update Script

This script is used for updating IP addresses in the configuration files of a BigBlueButton server. It supports a dry-run mode, which allows you to preview the changes that will be made before actually applying them.

## Some Information

80 percent of this repo is made and written by [OpenAI's Great ChatGPT Project](chat.openai.com), the only thing I did, was to give bash commands to ChatGPT, and what it did was:

1. Converting my bash commands into ansible, commenting the ansible file, and putting bash commands into a loop
2. Refactoring my bash commands, creating functions, adding a dry-run, using a loop for replacement and commenting it.
3. Writing most of this markdown files, and README.md :D
4. And at the end NAMING THIS REPO! xD

---

## Bash Usage

1. Download the script and make it executable by running the command `chmod +x bbb-ip-update.sh`.
2. Update the `old_ip` and `new_ip` variables with the current IP address and the new IP address that you want to use.
3. Update the `fqdn` variable with the fqdn of your server.
4. Optionally, update the `config_files` array with the path to any additional configuration files that you want to update.
5. Run the script with the command `./bbb-ip-update.sh`.

### Notes

- Be sure to test the playbook in a non-production environment before running it on a production server.
- The playbook assumes that the user running it has the necessary permissions to run the commands and that the necessary dependencies (e.g. bbb-conf, docker, sed) are installed on the host.


### Dry-run Mode

The script supports a dry-run mode, which allows you to preview the changes that will be made before actually applying them. To enable dry-run mode, set the `dry_run` variable to `true`.

### Note

- The script assumes that the `bbb-conf` script and the `docker-compose` command are in the system path.
- The script assumes that the `bbb-monitoring` is located in /root/bbb-monitoring
- The script assumes that the `docker-compose.yaml` is located in /root/bbb-monitoring

---

## Ansible Playbook

1. Edit the `vars` section of the playbook to specify the old IP address, the new IP address and the FQDN for your BigBlueButton server.
2. Run the playbook with the command `ansible-playbook -i <your-inventory-file> playbook.yaml`
3. Verify that the IP address has been updated in the specified files and that BigBlueButton is running correctly.

---


## Contribution

You are welcome to fork and contribute to this script.

## License

This script is released under the [MIT License](https://opensource.org/licenses/MIT).

## Support

If you have any issues or questions, please open an issue on the [Github repository](https://github.com/mrhalix/bbb-ip-update) or contact me directly.
