# Sensitive values

Sensitive values cascade from upstream modules to downstream ones.
Examples are passwords, private keys.

If a terraform value is marked as `sensitive = true` in any module or
provider, terraform will not output them in the root module.

Middle modules can access the value but importantly these taint whole
resources, if you output the whole thing. The work around is to output
individual values and store the sensitive ones in some secure storage,
like Secrets Manager.


## State storage

The state file does contain the raw sensitive value, so anyone with
access to that file can read its json content.
