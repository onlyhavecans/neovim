-- Custom filetype detection

vim.filetype.add({
  extension = {
    ["jsonc"] = "json5",
    ["nsp"] = "json",
    ["tin"] = "tintin",
  },
  filename = {
    [".envrc"] = "bash",
    [".env"] = "dotenv",
    [".markdownlintrc"] = "json",
  },
  pattern = {
    -- Ansible patterns
    ["site%.ya?ml"] = "yaml.ansible",
    ["playbook%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/inventory/.*%.ya?ml"] = "yaml.ansible",
    [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/molecule/.*/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/vars/.*%.ya?ml"] = "yaml.ansible",
    -- Nomad templates
    [".*nomad%.tpl"] = "tpl.hcl",
  },
})
