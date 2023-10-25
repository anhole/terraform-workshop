# Terraform documentation

> My code documents is self documenting!

or

> No need for documentation, just read the code!

or

> Someone has forgotten to create the documentation!

[What, Why, How: The Documentation Triangle](https://sourceless.org/posts/the-documentation-triangle.html)

* What - Code
  * Clear, concise, and well-written code?
  * Language you can understand?
* Why - Comments
  * Changes over time
  * Dependencies
  * Workarounds
* How - Context
  * Often neglected
  * "It all made sense when I wrote it"

```ascii
        What
         /\
        /  \
       /    \
      /      \
     /        \
    /__________\
 Why            How
```

## Concept

(Ab)use Terraform´s [https://developer.hashicorp.com/terraform/language/functions/templatefile](templatefile)
function to automatically generate documentation files. Instead of using `output` to write values to the terminal,
generate a file with all values filled.

Install [draw.io extension](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio)

## Demo

```bash
terraform init
terraform apply

# Open the README file in Preview mode
code PETS_README.MD
```

### Drawings

Template file can be used to modify many different filetypes. Having a drawing in the README makes it look more professional.

## Challenge

1. Add a cat with a name and random color to the drawing
