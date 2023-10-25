terraform {
  backend "local" {
    path = "./.terraform-states/terraform.tfstate"
  }
}

resource "random_pet" "human" {
  length    = 1
  separator = " "
}

resource "random_pet" "dog" {
  length    = 2
  separator = " "
}

resource "local_file" "pet_readme" {
  content = templatefile("./templates/PETS_README.md.tftpl",
    {
      human_name   = random_pet.human.id
      dog_name     = random_pet.dog.id
      drawing_path = local_file.pet_drawing.filename
  })

  filename        = "${path.module}/PETS_README.md"
  file_permission = "0644"
}

resource "local_file" "pet_drawing" {
  content = templatefile("./templates/drawing.drawio.svg",
    {
      human_name = random_pet.human.id
      dog_name   = random_pet.dog.id
  })

  filename        = "${path.module}/docs/drawing.drawio.svg"
  file_permission = "0644"
}
