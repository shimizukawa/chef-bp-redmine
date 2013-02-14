bp-redmine (rvm aware) Cookbook
================================

This cookbook install redmine plugins and set options for BePROUD.

Requirements
------------

#### cookbook
- `rvm`
- `rvm-redmine`
- `python`

Attributes
----------
nothing.

Usage
-----
#### bp-redmine::default

Include `bp-redmine` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[bp-redmine]"
  ]
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
