# Initial User

To use this role, `gather_facts` must be disabled at playbook level.

This role, checks if it can connect with the Ansible User.
If not, it will connect with `initial_user`, create `ansible_user`.

## Variables

| Variable               | Usage                                                                                                                   |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `initial_user`         | The user used for connection, if `ansible_user` doesn't work. The user will be deleted afterwards. (Defaults to `root`) |
| `ansible_user`         | The normal ansible connection user                                                                                      |
| `ansible_user_pubkeys` | Public keys, to deploy on `ansible_user`                                                                                |
| `remove_initial_user`  | Wether `Initial_User` should be deleted afterwards. (Defaults to `false`)                                               |
