mercurial-env Cookbook
=========================

This cookbook treat mercurial configurations.

Requirements
------------

#### cookbook
- `mercurial`

Attributes
----------

`node['mercurial_env']['owner']` - owner for extension and hgrc
`node['mercurial_env']['hgext_dir']` - extension install dirs: default is .hgext directory under owner's home.

`node['mercurial_env']['hgrc']['path']` - .hgrc file's absolute path: default is $HOME/.hgrc
`node['mercurial_env']['hgrc']['owner']` - .hgrc owner: set if owner is different with extension owner
`node['mercurial_env']['hgrc']['username']` - mercurial commit name
`node['mercurial_env']['hgrc']['hostfingerprints']` - hash as {domain => fingerprint}.
`node['mercurial_env']['hgrc']['bb]['username']` - bitbucket username
`node['mercurial_env']['hgrc']['bb]['password']` - bitbucket password if not use 'ssh' node_method.
`node['mercurial_env']['hgrc']['bb]['node_method']` - 'https' or 'ssh'


Usage
-----
#### mercurial-env::default

Include `mercurial-env` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mercurial-env]"
  ]
}
```

If you want to customize parameters, specify override_attributes field.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mercurial-env]"
  ],
  "override_attributes" : {
    "mercurial_env": {
      "hgrc": {
        "owner": "foobar"
      }
    }
  }
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Takayuki Shimizukawa
License: Apache 2.0
