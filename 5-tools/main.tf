resource "local_file" "file" {
  filename = "${path.module}/file.demo.txt"   
  content = "Content of a file"   
}


